//
//  ZYForeclosureHouseController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSliderViewController.h"
#import "ZYForeclosureHouseViewModel.h"

@interface ZYForeclosureHouseController : ZYSliderViewController
ZY_VIEW_MODEL_PROPERTY(ZYForeclosureHouseViewModel)
/**
 *  是否可以编辑
 */
@property(nonatomic,assign)BOOL edit;

@property(nonatomic,assign)long long projectID;
@end
