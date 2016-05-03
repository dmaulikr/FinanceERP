//
//  ZYSearchCleanCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/22.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSearchCleanCell.h"

@implementation ZYSearchCleanCell
{
    UIButton *clearButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearButton.frame = CGRectMake(2*GAP, GAP, FUll_SCREEN_WIDTH-4*GAP, [ZYSearchCleanCell defaultHeight]-2*GAP);
        [clearButton setTitle:@"清除搜索历史" forState:UIControlStateNormal];
        clearButton.titleLabel.font = FONT(14);
        [clearButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        [self addSubview:clearButton];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (RACSignal*)cleanButtonPressedSignal
{
    if(_cleanButtonPressedSignal==nil)
    {
        _cleanButtonPressedSignal = [clearButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanButtonPressedSignal;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
