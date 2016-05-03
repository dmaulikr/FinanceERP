//
//  ZYHomePageEventCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYTableViewCell.h"
#import "ZYWarningEvent.h"

@interface ZYHomePageEventCell : ZYTableViewCell

- (void)loadDataSource:(ZYWarningEvent*)event;

@end
