//
//  ZYTabBarController.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTabBarController : UITabBarController
/**
 *  tabBarController操作signal
 */
@property(nonatomic,strong)RACSignal *tabBarSignal;

@end
