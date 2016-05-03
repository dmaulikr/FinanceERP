//
//  ZYViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYViewModel : NSObject

- (void)reloadDataSource;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end
