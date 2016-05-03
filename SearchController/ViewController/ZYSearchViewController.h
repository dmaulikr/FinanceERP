//
//  ZYSearchViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYSearchViewModel.h"
#import "ZYTableViewController.h"

@interface ZYSearchViewController : ZYViewController

ZY_VIEW_MODEL_PROPERTY(ZYSearchViewModel)
/**
 *  联网 搜索
 */
@property(nonatomic,assign)BOOL netSearch;

@end
