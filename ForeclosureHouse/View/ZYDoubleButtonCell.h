//
//  ZYDoubleButtonCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/14.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTableViewCell.h"

@interface ZYDoubleButtonCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *leftButtonPressedSignal;
@property(nonatomic,strong)RACSignal *rightButtonPressedSignal;

@end
