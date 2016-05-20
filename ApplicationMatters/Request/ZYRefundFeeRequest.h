//
//  ZYRefundFeeRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYRefundFeeRequest : ZYRequest

@property (nonatomic, assign) CGFloat return_fee;

@property (nonatomic, copy) NSString *account_name;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *bank_name;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger project_id;

@property (nonatomic, assign) NSInteger pid;

@end
