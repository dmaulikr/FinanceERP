//
//  ZYAccountPurposeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

@interface ZYAccountPurposeModel : ZYStoreModel

@property(nonatomic,assign)NSInteger pid;

@property(nonatomic,assign)NSInteger num;

@property(nonatomic,strong)NSString *name;

@end
