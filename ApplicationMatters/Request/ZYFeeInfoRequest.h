//
//  ZYFeeInfoRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYFeeInfoRequest : ZYRequest

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger project_id;

@end
