//
//  ZYBusinessProcessingStateTopView.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateTopView.h"

@interface ZYBusinessProcessingStateTopView()


@end

@implementation ZYBusinessProcessingStateTopView
{
    CALayer *line;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if(line==nil)
    {
        line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        CGFloat height = 1/[UIScreen mainScreen].scale;
        line.frame = CGRectMake(0, rect.size.height-height, rect.size.width, height);
        [self.layer addSublayer:line];
    }
}


@end
