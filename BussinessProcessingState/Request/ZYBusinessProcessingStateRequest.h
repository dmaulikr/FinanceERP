//
//  ZYBusinessProcessingStateRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYBusinessProcessingStateRequest : ZYRequest

@property(nonatomic,assign)NSInteger user_id;

@property(nonatomic,assign)NSInteger biz_handle_id;
@end
