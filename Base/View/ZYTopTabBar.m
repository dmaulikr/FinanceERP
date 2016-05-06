//
//  ZYTopTabBar.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTopTabBar.h"

@implementation ZYTopTabBar

{
    NSArray *tabTitles;
}
- (instancetype)initWithTabs:(NSArray*)tabs
{
    self = [super init];
    if (self) {
        tabTitles = tabs;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger steps = tabTitles.count;
    CGFloat width = (FUll_SCREEN_WIDTH-(steps+1)*GAP)/steps;
    _buttonArr = [NSMutableArray arrayWithCapacity:steps];
    NSInteger idx = 0;
    for(NSString *title in tabTitles)
    {
        UIButton *stepButton = [UIButton buttonWithType:UIButtonTypeSystem];
        stepButton.frame = CGRectMake(GAP+idx*(GAP+width), GAP, width, self.height-GAP);
        [stepButton setTitle:title forState:UIControlStateNormal];
        stepButton.backgroundColor = [UIColor clearColor];
        [stepButton setTitleColor:[UIColor colorWithHexString:@"888888"] forState:UIControlStateNormal];
        [stepButton addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        stepButton.titleLabel.numberOfLines = 2;
        stepButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        stepButton.titleLabel.font = [UIFont systemFontOfSize:14];
        stepButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        stepButton.tag = idx;
        [self addSubview:stepButton];
        [_buttonArr addObject:stepButton];
        idx++;
    }
    [self setHighlightIndex:0];
}
- (void)setHighlightIndex:(NSInteger)highlightIndex
{
    _highlightIndex = highlightIndex;
    [_buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setTitleColor:[UIColor colorWithHexString:@"888888"] forState:UIControlStateNormal];
        if(idx==highlightIndex)
        {
            [button setTitleColor:BLUE forState:UIControlStateNormal];
        }
    }];
}
- (void)tabButtonPressed:(UIButton*)button{}
- (void)drawRect:(CGRect)rect
{
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    NSInteger steps = tabTitles.count;
    CGFloat tabWidth = (FUll_SCREEN_WIDTH-(steps+1)*GAP)/steps;
    
    CGFloat leftLength = (width-GAP-tabWidth-GAP)*_rate+GAP;
    
    //    CGFloat leftLength = _selecedIndex*(tabWidth+TAB_GAP)+TAB_GAP;
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1/[UIScreen mainScreen].scale);
    // 2.画线
    CGContextMoveToPoint(ctx, 0, height);
    CGContextAddLineToPoint(ctx, leftLength, height);
    CGContextAddLineToPoint(ctx, leftLength, GAP);
    CGContextAddLineToPoint(ctx, leftLength+tabWidth, GAP);
    CGContextAddLineToPoint(ctx, leftLength+tabWidth, height);
    CGContextAddLineToPoint(ctx, width, height);
    
    CGContextSetRGBStrokeColor(ctx, 136.f/255.f, 136.f/255.f, 136.f/255.f, 1);
    
    // 3.绘制图形
    CGContextStrokePath(ctx);
}
//- (void)setSelecedIndex:(NSInteger)selecedIndex
//{
//    _selecedIndex = selecedIndex;
//    [self setNeedsDisplay];
//}
- (void)setRate:(CGFloat)rate
{
    _rate = rate;
    [self setNeedsDisplay];
}

- (RACSignal*)tabButtonPressedSignal
{
    if(_tabButtonPressedSignal ==nil)
    {
        _tabButtonPressedSignal = [[self rac_signalForSelector:@selector(tabButtonPressed:)] map:^id(RACTuple *value) {
            UIButton *button = value.first;
            return @(button.tag);
        }];
    }
    return _tabButtonPressedSignal;
}

@end
