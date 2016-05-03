//
//  ZYBusinessProcessRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessRequest.h"

@implementation ZYBusinessProcessRequest
- (NSString *)requestUrl {
    return  @"/queryBizHandleList.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",
             @"is_my_biz",
             @"product_id",
             @"rows",
             @"page",];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60*30;
}
@end
