//
//  ZYSelectListController.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewController.h"
#import "ZYSelectListViewModel.h"


@interface ZYSelectListController : ZYTableViewController
ZY_VIEW_MODEL_PROPERTY(ZYSelectListViewModel);

@property(nonatomic,strong)RACSignal *selectSignal;

- (instancetype)initWithViewModel:(ZYSelectListViewModel*)viewModel;

@end
