//
//  ZYCustomerSecondUpdateRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYCustomerSecondUpdateRequest : ZYRequest



@property (nonatomic, copy) NSString *relation_phone_num;

@property (nonatomic, copy) NSString *acc_name;

@property (nonatomic, copy) NSString *bus_lic_cert;

@property (nonatomic, assign) float reg_money;

@property (nonatomic, copy) NSString *relation_card_no;

@property (nonatomic, copy) NSString *credit_no;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *cpy_name;

@property (nonatomic, assign) NSInteger customer_id;

@property (nonatomic, assign) NSInteger acc_use;

@property (nonatomic, copy) NSString *relation_address;

@property (nonatomic, copy) NSString *legal_person;

@property (nonatomic, assign) NSInteger acc_type;

@property (nonatomic, copy) NSString *com_telephone;

@property (nonatomic, copy) NSString *relation_name;

@property (nonatomic, copy) NSString *bank_name;

@property (nonatomic, assign) NSInteger relation_type;

@property (nonatomic, copy) NSString *org_code;

@property (nonatomic, copy) NSString *rep_query_date;

@property (nonatomic, copy) NSString *loan_card_id;



@end
