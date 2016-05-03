//
//  ZYBussinessStateCountRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/3.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessStateCountRequest.h"

@implementation ZYBussinessStateCountRequest
- (NSString *)requestUrl {
    return  @"/qeuryHandleDynamicCountMapList.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id"];
}
@end
