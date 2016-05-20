//
//  ZYApplyMattersRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplyMattersRequest.h"

@implementation ZYApplyMattersRequest
- (NSString *)requestUrl {
    return  @"/queryIndexRefundFee.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"back_fee_apply_status_list",
             @"product_id",
             @"rows",
             @"user_id",
             @"type",
             @"page",
             @"project_name"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*3600*30;
}
@end
