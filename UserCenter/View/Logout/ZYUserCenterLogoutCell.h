//
//  ZYUserCenterLogoutCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYUserCenterLogoutCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *logoutSignal;

@end
