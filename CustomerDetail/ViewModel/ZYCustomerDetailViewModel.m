//
//  ZYCustomerDetailViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerDetailViewModel.h"

@implementation ZYCustomerDetailViewModel
- (NSArray*)customerDetailTabTitles
{
    if(_customerDetailTabTitles==nil)
    {
        _customerDetailTabTitles = @[@"基本信息",@"工作信息",@"社保信息",@"家庭信息",@"开户信息",@"公司信息",@"关系人信息",@"征信记录"];
    }
    return _customerDetailTabTitles;
}
@end
