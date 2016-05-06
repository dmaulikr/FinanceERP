//
//  ZYForeclosureHouseSubController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSliderViewController.h"
#import "ZYForeclosureHouseViewModel.h"
#import "ZYSections.h"
@interface ZYForeclosureHouseSubController : ZYSliderViewController
ZY_VIEW_MODEL_PROPERTY(ZYForeclosureHouseViewModel)
- (instancetype)initWithModel:(ZYForeclosureHouseViewModel*)model;
/**
 *  绑定一个sections 用于向外界传递信号
 *
 *  @param sections 一个表格 对应一个sections  用于数据绑定
 */
- (void)blendSections:(ZYSections*)sections;

/**
 *  是否可以编辑
 */
@property(nonatomic,assign)BOOL edit;
@end
