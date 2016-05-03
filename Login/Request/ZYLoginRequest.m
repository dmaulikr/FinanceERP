//
//  ZYLoginRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYLoginRequest.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation ZYLoginRequest

- (NSString *)requestUrl {
    return  @"/login.action";
}

- (id)requestArgument {
    return [self mj_keyValues];
}

+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_name",@"password"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 60*2;//登陆超时 2 分钟
}
@end
