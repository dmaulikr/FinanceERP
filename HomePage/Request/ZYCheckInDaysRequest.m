//
//  ZYCheckInDaysRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/27.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCheckInDaysRequest.h"

@implementation ZYCheckInDaysRequest
- (NSString *)requestUrl {
    return  @"/getSignDays.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id"];
}
@end
