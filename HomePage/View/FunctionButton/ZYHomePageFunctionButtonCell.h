//
//  ZYHomePageFunctionButtonCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYHomePageFunctionButtonCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *functionButtonPressSignal;
/**
 *  根据用户角色来重新加载功能列表
 */
- (void)reloadFunctionButton:(ZYUser*)user;
@end
