//
//  ZYLoginViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"

@interface ZYLoginViewModel : ZYViewModel

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *password;

- (RACSignal*)login;
- (void)saveUserNameAndPassword;
@end
