//
//  ZYBusinessProcessStatueCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessStatueCell.h"

@interface ZYBusinessProcessStatueCell()

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

@end

@implementation ZYBusinessProcessStatueCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(ZYBusinessProcessModel *)model
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.userInteractionEnabled = YES;
    if(model.project_status==1)///可以修改 可以保存 可以提交审批
    {
        _cellTitleLabel.text = @"待申请";
        model.infoEdit = YES;
    }
    else if (model.project_status<=9&&model.project_status>=2)
    {
        
    }
    else if (model.project_status==10)
    {
        if(model.rec_status == 1)
        {
            _cellTitleLabel.text = @"未收费";
            self.accessoryType = UITableViewCellAccessoryNone;
            self.userInteractionEnabled = NO;
        }
        else if(model.rec_status == 2)
        {
            _cellTitleLabel.text = @"待放款";
        }
        else
        {
            //其他情况不考虑
        }
    }
    else if (model.project_status==11)
    {
        _cellTitleLabel.text = model.dynamic_name;
    }
    else if (model.project_status==12)
    {
        _cellTitleLabel.text = @"已完成";
    }
    else if (model.project_status==13)
    {
        _cellTitleLabel.text = @"已归档";
    }
}
@end
