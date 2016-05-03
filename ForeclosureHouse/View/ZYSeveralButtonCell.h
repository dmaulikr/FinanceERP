//
//  ZYSeveralButtonCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYSeveralButtonCell : ZYTableViewCell
@property(nonatomic,strong)RACSignal *leftButtonPressedSignal;
@property(nonatomic,strong)RACSignal *midButtonPressedSignal;
@property(nonatomic,strong)RACSignal *rightButtonPressedSignal;
@end
