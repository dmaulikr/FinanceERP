//
//  ZYBussinessProcessingStateEditRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYBussinessProcessingStateEditRequest : ZYRequest


@property (nonatomic, assign) NSInteger biz_handle_id;

@property (nonatomic, assign) NSInteger handle_dynamic_id;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *finish_date;

@property (nonatomic, copy) NSString *remark;


@end
