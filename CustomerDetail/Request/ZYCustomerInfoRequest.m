//
//  ZYCustomerInfoRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerInfoRequest.h"

@implementation ZYCustomerInfoRequest
- (NSString *)requestUrl {
    return  @"/queryCustomerInfoByCid.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",@"customer_id"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
