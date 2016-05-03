//
//  ZYLoginRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYLoginRequest : ZYRequest

@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *password;

@end
