//
//  ZYCustomerFirstUpdateRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYCustomerFirstUpdateRequest : ZYRequest

@property (nonatomic, assign) float total_liab;

@property (nonatomic, assign) float month_wage;

@property (nonatomic, assign) NSInteger total_safe_time;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, assign) float pen_money;

@property (nonatomic, assign) NSInteger house_shape;

@property (nonatomic, copy) NSString *safe_unit;

@property (nonatomic, assign) float family_income;

@property (nonatomic, assign) NSInteger suspend;

@property (nonatomic, assign) NSInteger house_main;

@property (nonatomic, assign) NSInteger customer_id;

@property (nonatomic, assign) float house_area;

@property (nonatomic, copy) NSString *spouse_name;

@property (nonatomic, copy) NSString *spouse_phone;

@property (nonatomic, assign) NSInteger degree;

@property (nonatomic, copy) NSString *safe_time;

@property (nonatomic, assign) float month_income;

@property (nonatomic, assign) NSInteger month_pay_day;

@property (nonatomic, copy) NSString *work_unit;

@property (nonatomic, assign) NSInteger live_status;

@property (nonatomic, copy) NSString *unit_address;

@property (nonatomic, copy) NSString *unit_phone;

@property (nonatomic, assign) float safe_num;

@property (nonatomic, assign) float med_money;

@property (nonatomic, assign) float total_assets;

@property (nonatomic, copy) NSString *spouse_card_no;

@property (nonatomic, copy) NSString *entry_time;

@property (nonatomic, assign) NSInteger occ_name;

@end
