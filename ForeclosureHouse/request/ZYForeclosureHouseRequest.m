//
//  ZYForeclosureHouseRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/4.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseRequest.h"

@implementation ZYForeclosureHouseRequest
- (NSString *)requestUrl {
    return  @"/queryProjectByPid.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",@"project_id"];
}
@end
