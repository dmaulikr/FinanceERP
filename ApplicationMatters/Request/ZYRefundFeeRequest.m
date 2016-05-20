//
//  ZYRefundFeeRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRefundFeeRequest.h"

@implementation ZYRefundFeeRequest
- (NSString *)requestUrl {
    return  @"/subApplyRefundFee.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"return_fee",
             @"account_name",
             @"account",
             @"bank_name",
             @"user_id",
             @"type",
             @"project_id",
             @"pid"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
