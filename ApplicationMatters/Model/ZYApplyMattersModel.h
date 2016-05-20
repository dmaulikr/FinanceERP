//
//  ZYApplyMattersModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYApplyMattersModel : NSObject

@property (nonatomic, copy) NSString *request_date;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, copy) NSString *product_name;

@property (nonatomic, assign) NSInteger back_fee_apply_status;

@property (nonatomic, assign) long long loan_money;

@property (nonatomic, assign) NSInteger project_id;

@property (nonatomic, assign) NSInteger product_type;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, strong) NSString *keyword;
@end
