//
//  ZYCalculatorButtonCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYCalculatorButtonCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *leftButtonPressedSignal;
@property(nonatomic,strong)RACSignal *rightButtonPressedSignal;

@end
