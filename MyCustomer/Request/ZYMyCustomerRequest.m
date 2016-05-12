//
//  ZYMyCustomerRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/10.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYMyCustomerRequest.h"

@implementation ZYMyCustomerRequest
- (NSString *)requestUrl {
    return  @"/queryCustomerList.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",@"customer_name",@"page",@"rows"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60;
}
@end
