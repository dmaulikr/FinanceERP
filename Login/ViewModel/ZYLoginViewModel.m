//
//  ZYLoginViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYLoginViewModel.h"
#import "ZYTools.h"

@implementation ZYLoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getUserNameAndPassword];
    }
    return self;
}
- (RACSignal*)login
{
    ZYLoginRequest *request = [ZYLoginRequest request];
    request.user_name = self.userName;
    request.password = self.password;
    return [[ZYRoute route] loginWith:request];
}
- (void)setUserName:(NSString *)userName
{
    _userName = __BASE64(userName);
}
- (void)setPassword:(NSString *)password
{
    _password = __BASE64(password);
}
- (void)saveUserNameAndPassword
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:_userName forKey:userNameKeychainName];
    [usernamepasswordKVPairs setObject:_password forKey:passwordKeychainName];
    [ZYTools saveKeychain:[ZYTools appVersionToken] data:usernamepasswordKVPairs];
}
- (void)getUserNameAndPassword
{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[ZYTools getKeychain:[ZYTools appVersionToken]];
    _userName = __TEXT([usernamepasswordKVPairs objectForKey:userNameKeychainName]);
    _password = __TEXT([usernamepasswordKVPairs objectForKey:passwordKeychainName]);
}
@end
