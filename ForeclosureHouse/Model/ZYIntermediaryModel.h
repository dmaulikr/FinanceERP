//
//  ZYIntermediaryModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"


@interface ZYIntermediaryModel : ZYStoreModel

@property(nonatomic,strong)NSString *look_desc;

@property(nonatomic,assign)NSInteger pid;

@property(nonatomic,assign)NSInteger rowid;
@end
