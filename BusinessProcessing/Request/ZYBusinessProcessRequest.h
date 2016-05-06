//
//  ZYBusinessProcessRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYBusinessProcessRequest : ZYRequest

@property (nonatomic, copy) NSString *dynamic_name;
//
@property (nonatomic, copy) NSString *project_name;
//
//@property (nonatomic, assign) NSInteger project_status;
//
//@property (nonatomic, assign) NSInteger biz_handle_id;
//
//@property (nonatomic, copy) NSString *project_number;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger is_my_biz;

@property (nonatomic, assign) NSInteger product_id;

@property (nonatomic, assign) NSInteger rows;

//@property (nonatomic, assign) NSInteger apply_handle_status;

//@property (nonatomic, assign) NSInteger project_id;

//@property (nonatomic, assign) NSInteger rec_status;

@property (nonatomic, assign) NSInteger page;

@end
