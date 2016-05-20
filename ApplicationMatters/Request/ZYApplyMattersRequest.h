//
//  ZYApplyMattersRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYApplyMattersRequest : ZYRequest

@property (nonatomic, copy) NSString *back_fee_apply_status_list;

@property (nonatomic, assign) NSInteger product_id;

@property (nonatomic, assign) NSInteger rows;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *project_name;

@end
