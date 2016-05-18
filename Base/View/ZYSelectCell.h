//
//  ZYSelectCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYSelectCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;
@property(nonatomic,strong)NSString *cellText;

@property(nonatomic,assign)BOOL cellNullable;/// 默认不能为空


#pragma mark - cell关联的 已选 选项
//自动加载选择内容
@property(nonatomic,assign)BOOL hiddenSelecedObj;

@property(nonatomic,assign)NSInteger selecedIndex;

@property(nonatomic,strong)id selecedObj;
//显示类的属性名称
@property(nonatomic,strong)NSString *showKey;

@property(nonatomic,strong)NSString *cellError;
@end
