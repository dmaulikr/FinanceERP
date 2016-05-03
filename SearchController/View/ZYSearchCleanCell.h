//
//  ZYSearchCleanCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/22.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTableViewCell.h"

@interface ZYSearchCleanCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *cleanButtonPressedSignal;

@end
