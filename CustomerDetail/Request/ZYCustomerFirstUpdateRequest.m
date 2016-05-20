//
//  ZYCustomerFirstUpdateRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerFirstUpdateRequest.h"

@implementation ZYCustomerFirstUpdateRequest
- (NSString *)requestUrl {
    return  @"/saveCustomerFamilyInfo.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"total_liab,month_wage",
             @"total_safe_time",
             @"user_id",
             @"pay_way",
             @"pen_money",
             @"house_shape",
             @"safe_unit",
             @"family_income",
             @"suspend",
             @"house_main",
             @"customer_id",
             @"house_area",
             @"spouse_name",
             @"spouse_phone",
             @"degree",
             @"safe_time",
             @"month_income",
             @"month_pay_day",
             @"work_unit",
             @"live_status",
             @"unit_address",
             @"unit_phone",
             @"safe_num",
             @"med_money",
             @"total_assets",
             @"spouse_card_no",
             @"entry_time",
             @"occ_name"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
