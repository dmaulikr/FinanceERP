//
//  ZYBussinessProcessingStateEditController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYBussinessProcessingStateEditViewModel.h"

@interface ZYBussinessProcessingStateEditController : ZYViewController
ZY_VIEW_MODEL_PROPERTY(ZYBussinessProcessingStateEditViewModel)
@property(nonatomic,assign)NSInteger businessProcessingID;
@end
