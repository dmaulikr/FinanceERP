//
//  ZYSingleButtonCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYSingleButtonCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *buttonPressedSignal;

@property(nonatomic,strong)NSString *buttonTitle;
@end
