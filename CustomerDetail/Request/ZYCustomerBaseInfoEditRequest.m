//
//  ZYCustomerBaseInfoEditRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerBaseInfoEditRequest.h"

@implementation ZYCustomerBaseInfoEditRequest
- (NSString *)requestUrl {
    return  @"/saveCustomerInfo.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"comm_address",
             @"file_id",
             @"user_id",
             @"phone_num",
             @"customer_id",
             @"card_no",
             @"customer_name"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
