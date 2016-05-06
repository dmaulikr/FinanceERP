//
//  ZYBanksRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBanksRequest.h"

@implementation ZYBanksRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type_name = @"BANK_NAME";
    }
    return self;
}
- (NSString *)requestUrl {
    return  @"/queryLookUpValue.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",@"type_name"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60*30;//一天缓存
}
@end
