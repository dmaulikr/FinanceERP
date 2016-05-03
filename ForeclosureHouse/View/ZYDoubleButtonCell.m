//
//  ZYDoubleButtonCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/14.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYDoubleButtonCell.h"

@interface ZYDoubleButtonCell()

//@property (weak, nonatomic) IBOutlet UIButton *leftButton;
//@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@end

@implementation ZYDoubleButtonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineHidden = YES;
        CGFloat sideGap = 20;
        CGFloat height = 40;
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(sideGap, ([ZYDoubleButtonCell defaultHeight]-height)/2.f, (FUll_SCREEN_WIDTH-3*sideGap)/2.f, height)];
        _leftButton.backgroundColor = ORANGE;
        [self addSubview:_leftButton];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setTitle:@"上一步" forState:UIControlStateNormal];
        
        [_leftButton roundRectWith:_leftButton.height*ROUND_RECT_HEIGHT_RATE];
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(2*sideGap+_leftButton.width, ([ZYDoubleButtonCell defaultHeight]-height)/2.f, (FUll_SCREEN_WIDTH-3*sideGap)/2.f, height)];
        _rightButton.backgroundColor = BLUE;
        [self addSubview:_rightButton];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitle:@"下一步" forState:UIControlStateNormal];
        
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
- (RACSignal*)rightButtonPressedSignal
{
    if(_rightButtonPressedSignal==nil)
    {
        _rightButtonPressedSignal = [_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButtonPressedSignal;
}

@end
