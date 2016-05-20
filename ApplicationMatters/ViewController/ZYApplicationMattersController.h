//
//  ZYApplicationMattersController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYApplicationMattersViewModel.h"



@interface ZYApplicationMattersController : ZYViewController
ZY_VIEW_MODEL_PROPERTY(ZYApplicationMattersViewModel)

@property(nonatomic,assign)ZYApplicationMattersType type;
@end
