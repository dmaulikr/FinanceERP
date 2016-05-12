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

@end

@implementation ZYBusinessProcessCell


+ (CGFloat)defaultHeight{
    return 93.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ZYBusinessProcessModel *)model
{
    _model = model;
    
    if(model.keyword)
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.project_name];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[model.project_name rangeOfString:model.keyword]];
        _cellTitleLabel.attributedText = str;
    }
    else
    {
        _cellTitleLabel.text = model.project_name;
    }
    
    _cellSubTitleLabel.text = model.product_name;
    _cellPriceLabel.text = [NSString stringWithFormat:@"%lld",model.loan_money];
    _cellDateLabel.text = model.project_pass_date;
    
}
@end
