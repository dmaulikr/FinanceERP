//
//  ZYCustomerSecondUpdateRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerSecondUpdateRequest.h"

@implementation ZYCustomerSecondUpdateRequest
- (NSString *)requestUrl {
    return  @"/saveCustomerBankInfo.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[
             @"relation_phone_num",
             @"acc_name",
             @"bus_lic_cert",
             @"reg_money",
             @"relation_card_no",
             @"credit_no",
             @"user_id",
             @"cpy_name",
             @"customer_id",
             @"acc_use",
             @"relation_address",
             @"legal_person",
             @"acc_type",
             @"com_telephone",
             @"relation_name",
             @"bank_name",
             @"relation_type",
             @"org_code",
             @"rep_query_date",
             @"loan_card_id",
             ];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
