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
/**
 *  第一页详情 包括 工作信息 社保信息 家庭信息  第二页包括 开户信息  公司信息  关系人信息  征信记录
 */
@property(nonatomic,assign)BOOL isSecondDetail;

@end
