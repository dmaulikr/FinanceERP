//
//  ZYMyCustomerCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/10.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"
#import "ZYCustomerModel.h"

@interface ZYMyCustomerCell : ZYTableViewCell
- (void)loadData:(ZYCustomerModel*)model;
@end
