//
//  ZYStepView.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStepView.h"

@implementation ZYStepView
{
    UIView *bgView;
    UILabel *label;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _highlightColor = [UIColor colorWithHexString:@"0086d1"];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        bgView.backgroundColor = _highlightColor;
        [self addSubview:bgView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        [self addSubview:label];
    }
    return self;
}
- (void)layoutSubviews
{
    self.backgroundColor = [UIColor colorWithHexString:@"e4e5df"];
    self.layer.cornerRadius = self.width/2.f;
    self.clipsToBounds = YES;
}
- (void)setText:(NSString *)text
{
    _text = text;
    label.text = text;
}
- (void)highlight:(BOOL)highlight
{
    if(highlight)
    {
        bgView.backgroundColor = _highlightColor;
        label.textColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.1 animations:^{
            bgView.frame = CGRectMake(0, 0, self.width, self.height);
        }];
    }
    else
    {
        label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        [UIView animateWithDuration:0.1 animations:^{
            bgView.frame = CGRectMake(0, 0, 0, self.height);
        }completion:^(BOOL finished) {
            bgView.backgroundColor = _highlightColor;
        }];
    }
}

@end
