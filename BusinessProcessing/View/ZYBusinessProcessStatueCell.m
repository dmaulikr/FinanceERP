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
- (void)setModel:(id)model
{
    if([model isKindOfClass:[ZYBusinessProcessModel class]])
    {
        ZYBusinessProcessModel *obj = (ZYBusinessProcessModel*)model;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.userInteractionEnabled = YES;
        if(obj.project_status==1)///可以修改 可以保存 可以提交审批
        {
            _cellTitleLabel.text = @"待申请";
            obj.infoEdit = YES;
        }
        else if (obj.project_status<=9&&obj.project_status>=2)
        {
            
        }
        else if (obj.project_status==10)
        {
            if(obj.rec_status == 1)
            {
                _cellTitleLabel.text = @"未收费";
                self.accessoryType = UITableViewCellAccessoryNone;
                self.userInteractionEnabled = NO;
            }
            else if(obj.rec_status == 2)
            {
                _cellTitleLabel.text = @"待放款";
            }
            else
            {
                //其他情况不考虑
            }
        }
        else if (obj.project_status==11)
        {
            _cellTitleLabel.text = obj.dynamic_name;
        }
        else if (obj.project_status==12)
        {
            _cellTitleLabel.text = @"已完成";
        }
        else if (obj.project_status==13)
        {
            _cellTitleLabel.text = @"已归档";
        }
    }
    if([model isKindOfClass:[ZYApplyMattersModel class]])
    {
        ZYApplyMattersModel *obj = (ZYApplyMattersModel*)model;
        switch (obj.back_fee_apply_status) {
            case 1:
                _cellTitleLabel.text = @"未申请";
                break;
            case 2:
                _cellTitleLabel.text = @"申请中";
                break;
            case 3:
                _cellTitleLabel.text = @"驳回";
                break;
            case 4:
                _cellTitleLabel.text = @"审核中";
                break;
            case 5:
                _cellTitleLabel.text = @"申请通过";
                break;
            case 6:
                _cellTitleLabel.text = @"申请不通过";
                break;
            case 7:
                _cellTitleLabel.text = @"已归档";
                break;
            default:
                break;
        }
    }
    
    
}
@end
