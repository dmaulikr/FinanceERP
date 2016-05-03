//
//  ZYValueModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/2.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYStoreModel.h"

@interface ZYValueModel : ZYStoreModel

///页面上要显示的文字
@property(nonatomic,strong)NSString *content;
///计算使用的数值
@property(nonatomic,strong)NSNumber *value;

@end
