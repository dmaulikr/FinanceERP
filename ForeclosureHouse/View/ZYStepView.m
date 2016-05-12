//
//  ZYStepView.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStepView.h"
#define STEP_WIDTH 60
#define STEP_HEIGHT 50
#define STEP_ROUND_VIEW_WIDTH 20
@implementation ZYStepView
{
    UILabel *titleLabel;
    
    UIView *bgView;
    UIView *transionView;
    UILabel *label;
    
    UIButton *tapButton;
}
- (instancetype)initWithPoint:(CGPoint)point
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, STEP_WIDTH, STEP_HEIGHT)];
    if (self) {
        _highlightColor = [UIColor colorWithHexString:@"0086d1"];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, STEP_WIDTH, 20)];
        titleLabel.font = FONT(12);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        
        titleLabel.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        [self addSubview:titleLabel];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 28, STEP_ROUND_VIEW_WIDTH, STEP_ROUND_VIEW_WIDTH)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"e4e5df"];
        bgView.layer.cornerRadius = STEP_ROUND_VIEW_WIDTH/2.f;
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        
        transionView = [[UIView alloc] initWithFrame:CGRectMake(20, 28, 0, STEP_ROUND_VIEW_WIDTH)];
        transionView.backgroundColor = _highlightColor;
        transionView.layer.cornerRadius = STEP_ROUND_VIEW_WIDTH/2.f;
        transionView.clipsToBounds = YES;
        [self addSubview:transionView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 28, STEP_ROUND_VIEW_WIDTH, STEP_ROUND_VIEW_WIDTH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.layer.cornerRadius = STEP_ROUND_VIEW_WIDTH/2.f;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        [self addSubview:label];
        
        tapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, STEP_WIDTH, STEP_HEIGHT)];
        [self addSubview:tapButton];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.backgroundColor = [UIColor colorWithHexString:@"e4e5df"];
//    self.layer.cornerRadius = self.width/2.f;
//    self.clipsToBounds = YES;
}
- (void)setText:(NSString *)text
{
    _text = text;
    label.text = text;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    titleLabel.text = title;
}
- (void)highlight:(BOOL)highlight
{
    if(highlight)
    {
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithHexString:@"0086d1"];
        transionView.backgroundColor = _highlightColor;
        label.textColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.1 animations:^{
            transionView.width = STEP_ROUND_VIEW_WIDTH;
        }];
    }
    else
    {
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        [UIView animateWithDuration:0.1 animations:^{
            transionView.width = 0;
        }completion:^(BOOL finished) {
            transionView.backgroundColor = _highlightColor;
        }];
    }
}
- (RACSignal*)tapSignal
{
    return [[tapButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
        return @(self.tag);
    }];
}
@end
