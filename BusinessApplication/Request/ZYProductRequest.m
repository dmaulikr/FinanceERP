//
//  ZYProductRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/27.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYProductRequest.h"

@implementation ZYProductRequest
- (NSString *)requestUrl {
    return  @"/queryProduct.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60*30;//一天缓存
}
@end
