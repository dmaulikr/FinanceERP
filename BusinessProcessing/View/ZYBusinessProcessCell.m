//
//  ZYBusinessProcessCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessCell.h"

@interface ZYBusinessProcessCell()

@property(nonatomic,weak)IBOutlet UILabel *cellTitleLabel;
@property(nonatomic,weak)IBOutlet UILabel *cellSubTitleLabel;
@property(nonatomic,weak)IBOutlet UILabel *cellPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel *cellDateLabel;

@property(nonatomic,weak)IBOutlet UILabel *cellStateLabel;
@property(nonatomic,weak)IBOutlet UIButton *cellButton;

@end

@implementation ZYBusinessProcessCell

- (void)awakeFromNib
{
    [_cellButton roundRectWith:_cellButton.height*ROUND_RECT_HEIGHT_RATE];
}
+ (CGFloat)defaultHeight{
    return 108.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ZYBusinessProcessModel *)model
{
    _model = model;
    _cellTitleLabel.text = model.project_name;
    _cellSubTitleLabel.text = model.product_name;
    _cellPriceLabel.text = [NSString stringWithFormat:@"%lld",model.loan_money];
    _cellDateLabel.text = model.project_pass_date;
    _cellStateLabel.text = model.dynamic_name;
}
@end
