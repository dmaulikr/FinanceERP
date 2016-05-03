//
//  ZYBusinessProcessModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYBusinessProcessModel : NSObject

@property (nonatomic, copy) NSString *project_number;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, copy) NSString *dynamic_name;

@property (nonatomic, copy) NSString *product_name;

@property (nonatomic, copy) NSString *project_pass_date;

@property (nonatomic, assign) NSInteger project_status;

@property (nonatomic, assign) long long loan_money;

@property (nonatomic, assign) NSInteger project_id;

@property (nonatomic, assign) NSInteger apply_handle_status;

@property (nonatomic, assign) NSInteger biz_handle_id;

@property (nonatomic, assign) NSInteger rec_status;

@end
