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
- (void)setModel:(id)model
{
    _model = model;
    if([model isKindOfClass:[ZYBusinessProcessModel class]])
    {
        ZYBusinessProcessModel *obj = (ZYBusinessProcessModel*)model;
        
        if(obj.keyword)
        {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:obj.project_name];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[obj.project_name rangeOfString:obj.keyword]];
            _cellTitleLabel.attributedText = str;
        }
        else
        {
            _cellTitleLabel.text = obj.project_name;
        }
        
        _cellSubTitleLabel.text = obj.product_name;
        _cellPriceLabel.text = [NSString stringWithFormat:@"%lld",obj.loan_money];
        _cellDateLabel.text = obj.project_pass_date;
    }
    if([model isKindOfClass:[ZYApplyMattersModel class]])
    {
        ZYApplyMattersModel *obj = (ZYApplyMattersModel*)model;
        
        if(obj.keyword)
        {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:obj.project_name];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[obj.project_name rangeOfString:obj.keyword]];
            _cellTitleLabel.attributedText = str;
        }
        else
        {
            _cellTitleLabel.text = obj.project_name;
        }
        
        _cellSubTitleLabel.text = obj.product_name;
        _cellPriceLabel.text = [NSString stringWithFormat:@"%lld",obj.loan_money];
        _cellDateLabel.text = obj.request_date;
        
    }
    
}
@end
