//
//  ZYCalculatorResultHeader.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorResultHeader.h"

@implementation ZYCalculatorResultHeader



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat width = 1/[UIScreen mainScreen].scale;
    
    CALayer *topLine = [CALayer layer];
    topLine.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
    topLine.frame = CGRectMake(0, 0, rect.size.width, width);
    [self.contentView.layer addSublayer:topLine];
    
    CALayer *bottomLine = [CALayer layer];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
    bottomLine.frame = CGRectMake(0, rect.size.height-1, rect.size.width, width);
    [self.contentView.layer addSublayer:bottomLine];
    
    for(int i=0;i<4;i++)
    {
        CGFloat gap = rect.size.width/5.f;
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        line.frame = CGRectMake(gap+gap*i, 10, width, rect.size.height-20.f);
        [self.contentView.layer addSublayer:line];
    }
}


@end
