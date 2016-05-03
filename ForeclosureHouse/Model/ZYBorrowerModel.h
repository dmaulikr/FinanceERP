//
//  ZYBorrowerModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYBorrowerModel : NSObject
///姓名
@property(nonatomic,strong)NSString *name;
///手机号
@property(nonatomic,strong)NSString *telephone;
///身份证号
@property(nonatomic,strong)NSString *cardNumber;

@end
