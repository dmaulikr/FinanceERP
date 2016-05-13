//
//  ZYBussinessProcessingStateEditViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessProcessingStateEditViewModel.h"

@implementation ZYBussinessProcessingStateEditViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)requestBusinessProcessingState
{
    ZYBusinessProcessingStateRequest *request = [ZYBusinessProcessingStateRequest request];
    request.user_id = [ZYUser user].pid;
    request.biz_handle_id = _businessProcessingID;
    _error = nil;
    self.loading = YES;
    @weakify(self)
    [[[ZYRoute route] businessProcessStateList:request] subscribeNext:^(ZYBusinessProcessingStateModel *states) {
        @strongify(self)
        NSString *state = @"发放贷款";
        int stateIndex = 0;
        for(int i=0;i<states.handle_flow_map_list.count;i++)
        {
            Handle_Flow_Map_List *flow = states.handle_flow_map_list[i];
            
            if(flow.can_handle)
            {
                state = flow.name;
                stateIndex = i;
                
                Handle_Dynamic_Map_List *dynamic = states.handle_dynamic_map_list[i];
                
                self.businessProcessingStatePageModel.businessProcessingStatePageStepID = dynamic.pid;
                self.businessProcessingStatePageModel.businessProcessingStatePageName = flow.name;
                
                self.businessProcessingStatePageModel.businessProcessingStatePageFinishDate = dynamic.finish_date;
//                //            model.businessProcessingStatePageHandler = @"";
                self.businessProcessingStatePageModel.businessProcessingStatePageOperrator = dynamic.operator;
                self.businessProcessingStatePageModel.businessProcessingStatePageHandleDays = [NSString stringWithFormat:@"%ld",(long)dynamic.handle_day];
                self.businessProcessingStatePageModel.businessProcessingStatePageRegulationsDays = [NSString stringWithFormat:@"%ld",(long)flow.fix_day];
                self.businessProcessingStatePageModel.businessProcessingStatePageDifferents = [NSString stringWithFormat:@"%ld",(long)dynamic.differ];
                self.businessProcessingStatePageModel.businessProcessingStatePageRemark = dynamic.remark;
            }
        }
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
- (void)requestBusinessProcessingEdit
{
    ZYBussinessProcessingStateEditRequest *request = [ZYBussinessProcessingStateEditRequest request];
    request.user_id = [ZYUser user].pid;
    request.biz_handle_id = _businessProcessingID;
    request.handle_dynamic_id = self.businessProcessingStatePageModel.businessProcessingStatePageStepID;
    request.finish_date = self.businessProcessingStatePageModel.businessProcessingStatePageFinishDate;
    request.remark = self.businessProcessingStatePageModel.businessProcessingStatePageRemark;
    _error = nil;
    self.loading = YES;
    _success = NO;
    @weakify(self)
    [[[ZYRoute route] businessProcessStateEdit:request] subscribeNext:^(id value) {
        @strongify(self)
        self.loading = NO;
        self.error = value;
        self.success = YES;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
        self.success = NO;
    } completed:^{
        
    }];
}
- (ZYBusinessProcessingStatePageModel*)businessProcessingStatePageModel
{
    if(_businessProcessingStatePageModel==nil)
    {
        _businessProcessingStatePageModel = [[ZYBusinessProcessingStatePageModel alloc] init];
    }
    return _businessProcessingStatePageModel;
}
@end
