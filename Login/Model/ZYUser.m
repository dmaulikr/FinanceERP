//
//  ZYUser.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"roles" : [ZYRole class]};
}

+ (instancetype)user
{
    static ZYUser *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[ZYUser alloc] init];
    });
    return user;
}

- (BOOL)isManager
{
    for(ZYRole *role in self.roles)
    {
        if([role.role_code isEqualToString:@"JUNIOR_ACCOUNT_MANAGER"])
        {
            return YES;
        }
    }
    return NO;
}

@end


@implementation ZYRole

@end


