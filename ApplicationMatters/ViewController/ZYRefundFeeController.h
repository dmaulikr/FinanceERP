//
//  ZYRefundFeeController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYRefundFeeViewModel.h"
#import "ZYTableViewController.h"


@interface ZYRefundFeeController : ZYTableViewController
ZY_VIEW_MODEL_PROPERTY(ZYRefundFeeViewModel)

@property(nonatomic,strong)ZYApplyMattersModel *model;
@property(nonatomic,assign)ZYApplicationMattersType type;
@property(nonatomic,strong)RACSignal *commitSuccessSignal;

@end
