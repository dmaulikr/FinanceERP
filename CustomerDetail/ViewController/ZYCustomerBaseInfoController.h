//
//  ZYCustomerBaseInfoController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYCustomerBaseInfoViewModel.h"
@interface ZYCustomerBaseInfoController : ZYViewController
ZY_VIEW_MODEL_PROPERTY(ZYCustomerBaseInfoViewModel)

@property(nonatomic,assign)BOOL edit;

@property(nonatomic,assign)NSInteger customerID;

@property(nonatomic,strong)RACSignal *hasEditSignal;

@end
