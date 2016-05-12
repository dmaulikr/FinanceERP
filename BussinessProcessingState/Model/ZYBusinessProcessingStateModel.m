//
//  ZYBusinessProcessingStateModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateModel.h"

@implementation ZYBusinessProcessingStateModel


+ (NSDictionary *)objectClassInArray{
    return @{@"handle_flow_map_list" : [Handle_Flow_Map_List class], @"handle_dynamic_map_list" : [Handle_Dynamic_Map_List class] ,@"handle_dynamic_file_map_list" : [handle_dynamic_file_map_list class]};
}
@end
@implementation Handle_Flow_Map_List

@end


@implementation Handle_Dynamic_Map_List

@end


@implementation Biz_Evaluate_Map

@end

@implementation handle_dynamic_file_map_list

@end

