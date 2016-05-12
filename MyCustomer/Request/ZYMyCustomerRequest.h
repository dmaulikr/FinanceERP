//
//  ZYMyCustomerRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/10.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYMyCustomerRequest : ZYRequest

@property(nonatomic,assign)NSInteger user_id;

@property(nonatomic,strong)NSString *customer_name;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSInteger rows;
@end
