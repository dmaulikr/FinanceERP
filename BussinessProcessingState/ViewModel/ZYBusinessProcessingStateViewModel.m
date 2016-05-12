//
//  ZYBusinessProcessingStateViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateViewModel.h"

@implementation ZYBusinessProcessingStateViewModel
- (void)requestBusinessProcessingState
{
    ZYBusinessProcessingStateRequest *request = [ZYBusinessProcessingStateRequest request];
    request.user_id = [ZYUser user].pid;
    request.biz_handle_id = _businessProcessingID;
    _error = nil;
    self.loading = YES;
    [[[ZYRoute route] businessProcessStateList:request] subscribeNext:^(ZYBusinessProcessingStateModel *states) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        NSString *state = @"发放贷款";
        int stateIndex = 0;
        for(int i=0;i<states.handle_flow_map_list.count;i++)
        {
            Handle_Dynamic_Map_List *dynamic = states.handle_dynamic_map_list[i];
            Handle_Flow_Map_List *flow = states.handle_flow_map_list[i];
            
            ZYBusinessProcessingStatePageModel *model = [[ZYBusinessProcessingStatePageModel alloc] init];
            model.businessProcessingStatePageName = flow.name;
            model.businessProcessingStatePageFinishDate = dynamic.finish_date;
//            model.businessProcessingStatePageHandler = @"";
            model.businessProcessingStatePageOperrator = dynamic.operator;
            model.businessProcessingStatePageHandleDays = [NSString stringWithFormat:@"%ld",(long)dynamic.handle_day];
            model.businessProcessingStatePageRegulationsDays = [NSString stringWithFormat:@"%ld",(long)flow.fix_day];
            model.businessProcessingStatePageDifferents = [NSString stringWithFormat:@"%ld",(long)dynamic.differ];
            model.businessProcessingStatePageRemark = dynamic.remark;
            [arr addObject:model];
            if(flow.can_handle)
            {
                state = flow.name;
                stateIndex = i;
            }
        }
        self.businessProcessingStateArr = arr;
        self.businessProcessingState = state;
        self.businessProcessingStateIndex = stateIndex;
        self.businessProcessingDays = states.sum_handle_days;
        self.loading = NO;
    } error:^(NSError *error) {
        self.error = error.domain;
        self.loading = NO;
    } completed:^{
        
    }];
}

@end
