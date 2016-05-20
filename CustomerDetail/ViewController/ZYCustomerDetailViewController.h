//
//  ZYCustomerDetailViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSliderViewController.h"
#import "ZYCustomerDetailViewModel.h"

@interface ZYCustomerDetailViewController : ZYSliderViewController
ZY_VIEW_MODEL_PROPERTY(ZYCustomerDetailViewModel)

@property(nonatomic,assign)BOOL edit;

@property(nonatomic,strong)ZYCustomerModel *customer;

@end
