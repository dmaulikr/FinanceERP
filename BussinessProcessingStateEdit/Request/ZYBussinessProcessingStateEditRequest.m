//
//  ZYBussinessProcessingStateEditRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessProcessingStateEditRequest.h"

@implementation ZYBussinessProcessingStateEditRequest
- (NSString *)requestUrl {
    return  @"/subHandleDynamic.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"biz_handle_id",
             @"handle_dynamic_id",
             @"user_id",
             @"finish_date",
             @"remark"];
}
@end
