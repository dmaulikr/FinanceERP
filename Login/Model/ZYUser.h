//
//  ZYUser.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYRole : NSObject

@property (nonatomic, copy) NSString *role_name;

@property (nonatomic, copy) NSString *role_code;

@property (nonatomic, assign) NSInteger pid;

@end

typedef enum : NSUInteger {
    ZYUserLoginSuccess = 1,
    ZYUserLogout = 0,
    ZYUserLoging = 2,//正在登录
} ZYUserLoginState;

@interface ZYUser : NSObject


@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger org_id;

@property (nonatomic, strong) NSArray<ZYRole *> *roles;

@property (nonatomic, copy) NSString *photo_url;

@property (nonatomic, copy) NSString *job_title;

@property (nonatomic, copy) NSString *real_name;

@property (nonatomic, copy) NSString *member_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *org_name;

@property (nonatomic, copy) NSString *maill;

@property (nonatomic, assign) NSInteger pid;

+ (instancetype)user;

- (BOOL)isManager;//是否是经理


@property(nonatomic,assign)ZYUserLoginState loginState;//是否已登陆

@end



