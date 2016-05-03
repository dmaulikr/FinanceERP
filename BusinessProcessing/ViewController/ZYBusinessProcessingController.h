//
//  ZYBusinessProcessingController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYBusinessProcessingViewModel.h"
@interface ZYBusinessProcessingController : ZYViewController
ZY_VIEW_MODEL_PROPERTY(ZYBusinessProcessingViewModel)
@property(nonatomic,assign)BOOL isMyBussiness;//是否是我的业务
@end
