//
//  ZYHomePageCheckInCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageCheckInCell.h"

@interface ZYHomePageCheckInCell()

//@property (weak, nonatomic) IBOutlet UILabel *checkInLabel;

@property (strong, nonatomic) UILabel *checkInLabel;
//@property (weak, nonatomic) IBOutlet UIButton *checkInButton;

@property (strong, nonatomic) UIButton *checkInButton;
@end


@implementation ZYHomePageCheckInCell

//- (void)awakeFromNib
//{
//    [_checkInButton roundRectWith:_checkInButton.height*ROUND_RECT_HEIGHT_RATE];
//}

+ (CGFloat)defaultHeight
{
    return 40.f;
}

- (void)setCheckInDays:(long)checkInDays
{
    _checkInDays = checkInDays;
    
    NSString *dayStr = [NSString stringWithFormat:@"%ld",checkInDays];
    
    NSMutableAttributedString *attributedDayStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已签到%@天",dayStr]];
    
    /**
     * 更改字体大小
     */
    [attributedDayStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:[attributedDayStr.string rangeOfString:dayStr]];
    /**
     *  更改字体颜色
     */
    [attributedDayStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"f9bf00"] range:[attributedDayStr.string rangeOfString:dayStr]];
    
    _checkInLabel.attributedText = attributedDayStr;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat height = 26;
        CGFloat width = 60;
        _checkInButton = [[UIButton alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-width-GAP, ([ZYHomePageCheckInCell defaultHeight]-height)/2.f, width, height)];
        [_checkInButton roundRectWith:_checkInButton.height*ROUND_RECT_HEIGHT_RATE];
        _checkInButton.backgroundColor = BLUE;
        _checkInButton.titleLabel.font = FONT(14);
        [_checkInButton addTarget:self action:@selector(checkInButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkInButton setTitle:@"签到" forState:UIControlStateNormal];
        [self addSubview:_checkInButton];
        
        _checkInLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, FUll_SCREEN_WIDTH-width-3*GAP, [ZYHomePageCheckInCell defaultHeight])];
        _checkInLabel.textColor = TITLE_COLOR;
        _checkInLabel.font = FONT(14);
        [self addSubview:_checkInLabel];
    }
    return self;
}

- (void)setHasCheckIn:(BOOL)hasCheckIn
{
    _hasCheckIn = hasCheckIn;
    if(hasCheckIn)///已签到
    {
        _checkInButton.userInteractionEnabled = NO;
        [_checkInButton setBackgroundColor:TEXT_COLOR];
    }
    else
    {
        _checkInButton.userInteractionEnabled = YES;
        [_checkInButton setBackgroundColor:BLUE];
    }
}
- (void)checkInButtonPressed{}
- (RACSignal*)checkInButtonPressedSignal
{
    if(_checkInButtonPressedSignal==nil)
    {
        _checkInButtonPressedSignal = [self rac_signalForSelector:@selector(checkInButtonPressed)];
    }
    return _checkInButtonPressedSignal;
}
@end
