//
//  ZYCalculatorButtonCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorButtonCell.h"

@interface ZYCalculatorButtonCell ()

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation ZYCalculatorButtonCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_leftButton roundRectWith:_leftButton.height*ROUND_RECT_HEIGHT_RATE];
    [_rightButton roundRectWith:_rightButton.height*ROUND_RECT_HEIGHT_RATE];
}
+ (CGFloat)defaultHeight
{
    return 120.f;
}
- (RACSignal*)leftButtonPressedSignal
{
    if(_leftButtonPressedSignal==nil)
    {
        _leftButtonPressedSignal = [_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButtonPressedSignal;
}
- (RACSignal*)rightButtonPressedSignal
{
    if(_rightButtonPressedSignal==nil)
    {
        _rightButtonPressedSignal = [_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButtonPressedSignal;
}
@end
