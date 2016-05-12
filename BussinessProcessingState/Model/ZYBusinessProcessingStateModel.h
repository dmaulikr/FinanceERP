//
//  ZYBusinessProcessingStateModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Handle_Flow_Map_List,Handle_Dynamic_Map_List,Biz_Evaluate_Map,handle_dynamic_file_map_list;
@interface ZYBusinessProcessingStateModel : NSObject


@property (nonatomic, strong) NSArray<Handle_Flow_Map_List *> *handle_flow_map_list;

@property (nonatomic, assign) NSInteger sum_handle_days;

@property (nonatomic, strong) NSArray<Handle_Dynamic_Map_List *> *handle_dynamic_map_list;


@end
@interface Handle_Flow_Map_List : NSObject

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger fix_day;

@property (nonatomic, assign) NSInteger one_level;

@property (nonatomic, assign) BOOL can_handle;

@property (nonatomic, assign) NSInteger two_level;

@property (nonatomic, assign) NSInteger three_level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger advance_notice_day;

@end

@interface Handle_Dynamic_Map_List : NSObject

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger differ;

@property (nonatomic, copy) NSString *finish_date;

@property (nonatomic, assign) NSInteger handle_flow_id;

@property (nonatomic, strong) NSArray<handle_dynamic_file_map_list *> *handle_dynamic_file_map_list;

@property (nonatomic, strong) Biz_Evaluate_Map *biz_evaluate_map;

@property (nonatomic, copy) NSString *operator;

@property (nonatomic, assign) NSInteger handle_day;

@property (nonatomic, assign) NSInteger pid;

@end

@interface Biz_Evaluate_Map : NSObject

@property (nonatomic, assign) NSInteger like;

@property (nonatomic, assign) NSInteger dis_like;

@end

@interface handle_dynamic_file_map_list : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *url;

@end

