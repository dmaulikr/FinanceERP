//
//  ZYSelectListCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSelectListCell.h"

@interface ZYSelectListCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

@end

@implementation ZYSelectListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
}
@end
