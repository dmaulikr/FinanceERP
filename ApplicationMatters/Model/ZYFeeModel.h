//
//  ZYFeeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFeeModel : NSObject

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *bank_name;

@property (nonatomic, assign) float return_fee;

@property (nonatomic, copy) NSString *account_name;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger project_id;

@end
