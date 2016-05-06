//
//  ZYBankModel.h
//  LKDBHelper
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "ZYStoreModel.h"

@interface ZYBankModel : ZYStoreModel//可以网络更新数据库对象

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, copy) NSString *look_desc;

@end
