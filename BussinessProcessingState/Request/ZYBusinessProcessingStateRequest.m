//
//  ZYBusinessProcessingStateRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateRequest.h"

@implementation ZYBusinessProcessingStateRequest
- (NSString *)requestUrl {
    return  @"/queryBizHandleDynamic.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",
             @"biz_handle_id"];
}
@end
