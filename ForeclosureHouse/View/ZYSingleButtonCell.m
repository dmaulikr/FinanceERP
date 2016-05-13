//
//  ZYSingleButtonCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSingleButtonCell.h"

@interface ZYSingleButtonCell()

//@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) UIButton *button;

@end

@implementation ZYSingleButtonCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (RACSignal*)buttonPressedSignal
{
    if(_buttonPressedSignal==nil)
    {
        _buttonPressedSignal = [_button rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonPressedSignal;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineHidden = YES;
        CGFloat sideGap = 20;
        CGFloat height = 40;
        _button = [[UIButton alloc] initWithFrame:CGRectMake(sideGap, ([ZYSingleButtonCell defaultHeight]-height)/2.f, FUll_SCREEN_WIDTH-2*sideGap, height)];
        _button.backgroundColor = BLUE;
        [self addSubview:_button];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitle:@"下一步" forState:UIControlStateNormal];
        
        [_button roundRectWith:_button.height*ROUND_RECT_HEIGHT_RATE];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
+ (CGFloat)defaultHeight
{
    return 120.f;
}
- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
