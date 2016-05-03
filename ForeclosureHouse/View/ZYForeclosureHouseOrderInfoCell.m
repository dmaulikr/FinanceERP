//
//  ZYForeclosureHouseOrderInfoCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseOrderInfoCell.h"


@interface ZYForeclosureHouseOrderInfoCell ()
//@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
//@property (weak, nonatomic) IBOutlet UIStepper *leftSteper;
//@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
//@property (weak, nonatomic) IBOutlet UIStepper *rightSteper;
//@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
//@property (weak, nonatomic) IBOutlet UIButton *dropButton;


@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UIStepper *leftSteper;
@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UIStepper *rightSteper;
@property (strong, nonatomic) UILabel *rightLabel;
@property (strong, nonatomic) UIButton *dropButton;
@end

@implementation ZYForeclosureHouseOrderInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat tailLableWidth = 40;
        _dropButton = [[UIButton alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-GAP, 0, tailLableWidth, [ZYForeclosureHouseOrderInfoCell defaultHeight])];
        [_dropButton setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
        [_dropButton addTarget:self action:@selector(dropButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dropButton];
        
        CGFloat steperHeight = 29;
        CGFloat steperWidth = 94;
        _rightSteper = [[UIStepper alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-steperWidth-2*GAP, GAP, steperWidth, steperHeight)];
        _rightSteper.minimumValue = 0;
        _rightSteper.maximumValue = 100;
        _rightSteper.stepValue = 1;
        _rightSteper.tintColor = BLUE;
        [_rightSteper addTarget:self action:@selector(rightStepsPressed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_rightSteper];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-steperWidth-2*GAP, GAP+steperHeight, steperWidth, [ZYForeclosureHouseOrderInfoCell defaultHeight]-GAP-steperHeight)];
        _rightLabel.text = @"0";
        _rightLabel.font = FONT(12);
        _rightLabel.textColor = TITLE_COLOR;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_rightLabel];
        
        _leftSteper = [[UIStepper alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-2*steperWidth-3*GAP, GAP, steperWidth, steperHeight)];
        _leftSteper.minimumValue = 0;
        _leftSteper.maximumValue = 100;
        _leftSteper.stepValue = 1;
        _leftSteper.tintColor = BLUE;
        [_leftSteper addTarget:self action:@selector(leftStepsPressed:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_leftSteper];
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-2*steperWidth-3*GAP, GAP+steperHeight, steperWidth, [ZYForeclosureHouseOrderInfoCell defaultHeight]-GAP-steperHeight)];
        _leftLabel.text = @"0";
        _leftLabel.font = FONT(12);
        _leftLabel.textColor = TITLE_COLOR;
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_leftLabel];
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, FUll_SCREEN_WIDTH-tailLableWidth-2*steperWidth-5*GAP, [ZYForeclosureHouseOrderInfoCell defaultHeight])];
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.numberOfLines = 2;
        _cellTitleLabel.textColor = TITLE_COLOR;
        _cellTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cellTitleLabel];
        
        _buttonPressedSignal = [self rac_signalForSelector:@selector(dropButtonPressed:)];
    }
    return self;
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
}
- (void)leftStepsPressed:(id)sender {
    _leftLabel.text = [NSString stringWithFormat:@"%ld",(long)_leftSteper.value];
    self.cellLeftSteps = _leftSteper.value;
}
- (void)rightStepsPressed:(id)sender {
    _rightLabel.text = [NSString stringWithFormat:@"%ld",(long)_rightSteper.value];
    self.cellRightSteps = _rightSteper.value;
}
- (void)setCellLeftSteps:(NSInteger)cellLeftSteps
{
    _cellLeftSteps = cellLeftSteps;
    _leftLabel.text = [NSString stringWithFormat:@"%ld",(long)_cellLeftSteps];
    _leftSteper.value = _cellLeftSteps;
}
- (void)setCellRightSteps:(NSInteger)cellRightSteps
{
    _cellRightSteps = cellRightSteps;
    _rightLabel.text = [NSString stringWithFormat:@"%ld",(long)_cellRightSteps];
    _rightSteper.value = _cellRightSteps;
}
- (void)dropButtonPressed:(id)sender {
}
+ (CGFloat)defaultHeight{
    return 60.f;
}
- (void)setButtonRotate:(BOOL)buttonRotate
{
    if(buttonRotate)
    {
        [UIView animateWithDuration:0.1 animations:^{
            _dropButton.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            _dropButton.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
//    [super setUserInteractionEnabled:userInteractionEnabled];
    if(userInteractionEnabled)
    {
        _leftSteper.hidden = NO;
        _rightSteper.hidden = NO;
        _rightLabel.frame = CGRectMake(FUll_SCREEN_WIDTH-_dropButton.width-_rightSteper.width-2*GAP, GAP+_rightSteper.height, _rightSteper.width, [ZYForeclosureHouseOrderInfoCell defaultHeight]-GAP-_rightSteper.height);
        _leftLabel.frame = CGRectMake(FUll_SCREEN_WIDTH-_dropButton.width-2*_leftSteper.width-3*GAP, GAP+_leftSteper.height, _leftSteper.width, _leftSteper.height);
        _rightLabel.font = FONT(12);
        _leftLabel.font = FONT(12);
    }
    else
    {
        _leftSteper.hidden = YES;
        _rightSteper.hidden = YES;
        _rightLabel.Y = 0;
        _rightLabel.font = FONT(14);
        _leftLabel.font = FONT(14);
        _leftLabel.Y = 0;
        _leftLabel.height = [ZYForeclosureHouseOrderInfoCell defaultHeight];
        _rightLabel.height = [ZYForeclosureHouseOrderInfoCell defaultHeight];
    }
}
@end
