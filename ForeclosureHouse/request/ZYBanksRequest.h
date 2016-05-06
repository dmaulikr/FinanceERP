//
//  ZYBanksRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYBanksRequest : ZYRequest

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, strong) NSString *type_name;

@end
