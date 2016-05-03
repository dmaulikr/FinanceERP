//
//  ZYWarningEvent.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYWarningEvent : NSObject

@property (nonatomic, copy) NSString *flow_name;

@property (nonatomic, copy) NSString *project_name;

@property (nonatomic, copy) NSString *create_date;

@property (nonatomic, assign) NSInteger differ;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger project_id;

@end
