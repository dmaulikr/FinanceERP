//
//  ZYBusinessProcessingStateController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSliderViewController.h"
#import "ZYBusinessProcessingStateViewModel.h"

@interface ZYBusinessProcessingStateController : ZYSliderViewController
ZY_VIEW_MODEL_PROPERTY(ZYBusinessProcessingStateViewModel)
@property(nonatomic,assign)NSInteger businessProcessingID;

@property(nonatomic,assign)BOOL edit;
@end
