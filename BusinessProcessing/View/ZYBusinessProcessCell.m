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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellStateLabelCenterY;

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
    
    _cellButton.hidden = NO;
    _cellStateLabelCenterY.constant = -20.f;
    if(model.project_status==1)///可以修改 可以保存 可以提交审批
    {
        _cellStateLabel.text = @"待申请";
        [_cellButton setTitle:@"申请" forState:UIControlStateNormal];
    }
    else if (model.project_status<=9&&model.project_status>=2)
    {
        
    }
    else if (model.project_status==10)
    {
        if(model.rec_status == 1)
        {
            _cellStateLabel.text = @"未收费";
            _cellButton.hidden = YES;
            _cellStateLabelCenterY.constant = 0;
        }
        else if(model.rec_status == 1)
        {
            _cellStateLabel.text = @"待放款";
            [_cellButton setTitle:@"查看" forState:UIControlStateNormal];
        }
        else
        {
            //其他情况不考虑
        }
    }
    else if (model.project_status==11)
    {
        _cellStateLabel.text = @"已放款";
        [_cellButton setTitle:@"查看" forState:UIControlStateNormal];
    }
    else if (model.project_status==12)
    {
        _cellStateLabel.text = @"已完成";
        [_cellButton setTitle:@"查看" forState:UIControlStateNormal];
    }
    else if (model.project_status==13)
    {
        _cellStateLabel.text = @"已归档";
        [_cellButton setTitle:@"查看" forState:UIControlStateNormal];
    }
}
@end
