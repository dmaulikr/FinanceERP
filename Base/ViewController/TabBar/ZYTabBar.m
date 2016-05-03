//
//  ZYTabBar.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTabBar.h"

@implementation ZYTabBar
{
    NSArray *_buttonItems;
    UIButton *lastButton;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonItems = @[@"主页",@"信贷工具",@"我的"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat gap = (width - _buttonItems.count*height*2)/(_buttonItems.count+1);
    
    [_buttonItems enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tabButton setTitle:title forState:UIControlStateNormal];
        [tabButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tabButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%ld_no",idx+1]] forState:UIControlStateNormal];
        tabButton.tag = idx+1;
        tabButton.frame = CGRectMake(gap*(idx+1)+height*2*idx, 0, height*2, height);
        [tabButton setTitle:title forState:UIControlStateNormal];
        tabButton.titleLabel.font = [UIFont systemFontOfSize:10];
        tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        /**
         *  校正 文字 和图片
         */
        if(idx==0||idx==2)
        {
            tabButton.titleEdgeInsets = UIEdgeInsetsMake(35, -15, 0, 0);
        }
        else
        {
            tabButton.titleEdgeInsets = UIEdgeInsetsMake(35, -20, 0, 0);
        }
        tabButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 35, 0, 0);
        [tabButton addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tabButton];
        
        if(idx==0)
        {
            [self tabButtonPressed:tabButton];
        }
    }];
}
- (void)tabButtonPressed:(UIButton*)button
{
    [lastButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%ld_no",lastButton.tag]] forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%ld_cur",button.tag]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"0086d1"] forState:UIControlStateNormal];
    lastButton = button;
}
- (RACSignal*)tabBarSignal
{
    if(_tabBarSignal==nil)
    {
        _tabBarSignal = [[[self rac_signalForSelector:@selector(tabButtonPressed:)] map:^id(RACTuple *value) {
            return value.first;
        }] map:^id(UIButton *button) {
            return @(button.tag-1);
        }];
    }
    return _tabBarSignal;
}
@end
