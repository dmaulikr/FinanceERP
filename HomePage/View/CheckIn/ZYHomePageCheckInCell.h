//
//  ZYHomePageCheckInCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYHomePageCheckInCell : ZYTableViewCell
/**
 *  签到天数
 */
@property(nonatomic,assign)long checkInDays;

@property(nonatomic,assign)BOOL hasCheckIn;

@property(nonatomic,strong)RACSignal *checkInButtonPressedSignal;
@end
