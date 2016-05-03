//
//  ZYSeveralButtonCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSeveralButtonCell.h"
@interface ZYSeveralButtonCell()
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *midButton;
@property (strong, nonatomic) UIButton *rightButton;
@end
@implementation ZYSeveralButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineHidden = YES;
        CGFloat sideGap = 20;
        CGFloat height = 40;
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(sideGap, ([ZYSeveralButtonCell defaultHeight]-height)/2.f, (FUll_SCREEN_WIDTH-4*sideGap)/3.f, height)];
        _leftButton.backgroundColor = ORANGE;
        [self addSubview:_leftButton];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setTitle:@"上一步" forState:UIControlStateNormal];
        
        [_leftButton roundRectWith:_leftButton.height*ROUND_RECT_HEIGHT_RATE];
        
        _midButton = [[UIButton alloc] initWithFrame:CGRectMake(2*sideGap+_leftButton.width, ([ZYSeveralButtonCell defaultHeight]-height)/2.f, (FUll_SCREEN_WIDTH-4*sideGap)/3.f, height)];
        _midButton.backgroundColor = YELLOW;
        [self addSubview:_midButton];
        [_midButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_midButton setTitle:@"保存" forState:UIControlStateNormal];
        
        [_midButton roundRectWith:_leftButton.height*ROUND_RECT_HEIGHT_RATE];
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(3*sideGap+_leftButton.width+_midButton.width, ([ZYSeveralButtonCell defaultHeight]-height)/2.f, (FUll_SCREEN_WIDTH-4*sideGap)/3.f, height)];
        _rightButton.backgroundColor = BLUE;
        [self addSubview:_rightButton];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitle:@"提交审核" forState:UIControlStateNormal];
        
        [_rightButton roundRectWith:_rightButton.height*ROUND_RECT_HEIGHT_RATE];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    [_leftButton roundRectWith:_leftButton.height*ROUND_RECT_HEIGHT_RATE];
    [_rightButton roundRectWith:_rightButton.height*ROUND_RECT_HEIGHT_RATE];
    self.lineHidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
- (RACSignal*)midButtonPressedSignal
{
    if(_midButtonPressedSignal==nil)
    {
        _midButtonPressedSignal = [_midButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _midButtonPressedSignal;
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
