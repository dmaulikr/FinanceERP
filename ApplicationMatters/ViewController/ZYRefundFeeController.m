//
//  ZYRefundFeeController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRefundFeeController.h"
#import "ZYInputCell.h"
#import "ZYSingleButtonCell.h"
#import "ZYRefundCounterFeeSections.h"
#import "ZYRefundConsultingFeeSections.h"

@interface ZYRefundFeeController ()

@end

@implementation ZYRefundFeeController
{
    
}
ZY_VIEW_MODEL_GET(ZYRefundFeeViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    RACChannelTo(self.viewModel, type) = RACChannelTo(self, type);
    RACChannelTo(self.viewModel, model) = RACChannelTo(self, model);
    
    if(self.type==ZYApplicationMattersTypeRefundCounterFee)
    {
        ZYRefundCounterFeeSections *sections = [[ZYRefundCounterFeeSections alloc] initWithTitle:@"退手续费"];
        [sections blendModel:self.viewModel];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            if(value.first)
            {
                [self tip:value.first touch:NO];
            }
            else
            {
                [self.viewModel refundFeeRequest];
            }
        }];
        self.navigationItem.title = @"退手续费";
        self.sections = sections.sections;
    }
    if(self.type==ZYApplicationMattersTypeRefundConsultingFee)
    {
        ZYRefundConsultingFeeSections *sections = [[ZYRefundConsultingFeeSections alloc] initWithTitle:@"退咨询费"];
        [sections blendModel:self.viewModel];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            if(value.first)
            {
                [self tip:value.first touch:NO];
            }
            else
            {
                [self.viewModel refundFeeRequest];
            }
        }];
        self.navigationItem.title = @"退咨询费";
        self.sections = sections.sections;
    }
    if(self.type==ZYApplicationMattersTypeRefundRetainageFee)
    {
        ZYRefundConsultingFeeSections *sections = [[ZYRefundConsultingFeeSections alloc] initWithTitle:@"退尾款"];
        [sections blendModel:self.viewModel];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            if(value.first)
            {
                [self tip:value.first touch:NO];
            }
            else
            {
                [self.viewModel refundFeeRequest];
            }
        }];
        self.navigationItem.title = @"退尾款";
        self.sections = sections.sections;
    }
    [self.viewModel getFeeInfo];
}
- (void)blendViewModel
{
    [RACObserve(self.viewModel, loading) subscribeNext:^(id x) {
        if([x boolValue])
        {
            [self loading:YES];
        }
        else
        {
            [self stop];
        }
    }];
    [RACObserve(self.viewModel, error) subscribeNext:^(id x) {
        [self tip:x touch:NO];
    }];
    [RACObserve(self.viewModel, success) subscribeNext:^(id x) {
        if([x boolValue])
        {
            [self commitSuccess];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }
    }];
}
- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)commitSuccess{}
- (RACSignal*)commitSuccessSignal
{
    if(_commitSuccessSignal==nil)
    {
        _commitSuccessSignal = [self rac_signalForSelector:@selector(commitSuccess)];
    }
    return _commitSuccessSignal;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
