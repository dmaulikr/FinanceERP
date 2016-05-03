//
//  ZYForeclosureHouseOrderInfoCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYForeclosureHouseOrderInfoCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;
@property(nonatomic,assign)NSInteger cellLeftSteps;
@property(nonatomic,assign)NSInteger cellRightSteps;

@property(nonatomic,strong)RACSignal *buttonPressedSignal;

@property(nonatomic,assign)BOOL buttonRotate;
@end
