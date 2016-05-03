//
//  ZYCalculatorSliderBar.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorSliderBar.h"

@implementation ZYCalculatorSliderBar


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat width = 1/[UIScreen mainScreen].scale;
    
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
    line.frame = CGRectMake(0, rect.size.height-width, rect.size.width, width);
    [self.layer addSublayer:line];
    
    for(int i=0;i<2;i++)
    {
        CGFloat gap = rect.size.width/3.f;
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        line.frame = CGRectMake(gap+gap*i, 10, width, rect.size.height-20.f);
        [self.layer addSublayer:line];
    }
    
}


@end
