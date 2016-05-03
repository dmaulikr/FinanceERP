//
//  ZYHomePageEventView.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTableViewCell.h"

@interface ZYHomePageEventView : ZYTableViewCell
/**
 *  事件数组
 */
@property(nonatomic,strong)NSArray *eventArr;

+ (CGSize)defaultSize;

@end
