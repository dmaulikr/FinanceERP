//
//  ZYSegmentedCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYSegmentedCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;
@property(nonatomic,strong)NSArray *cellSegmentedTitles;
@property(nonatomic,assign)NSInteger cellSegmentedSelecedIndex;

@end
