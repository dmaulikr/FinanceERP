//
//  ZYCustomerInfoRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYCustomerInfoRequest : ZYRequest
@property(nonatomic,assign)NSInteger user_id;
@property(nonatomic,assign)NSInteger customer_id;
@end
