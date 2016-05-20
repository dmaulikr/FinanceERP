//
//  ZYFeedbackRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYFeedbackRequest : ZYRequest

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *feedback_content;

@property (nonatomic, assign) NSInteger problem_source;

@end
