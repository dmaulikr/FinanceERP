//
//  ZYCustomerBaseInfoEditRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYCustomerBaseInfoEditRequest : ZYRequest

@property (nonatomic, copy) NSString *comm_address;

@property (nonatomic, assign) NSInteger file_id;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *phone_num;

@property (nonatomic, assign) NSInteger customer_id;

@property (nonatomic, copy) NSString *card_no;

@property (nonatomic, copy) NSString *customer_name;

@end
