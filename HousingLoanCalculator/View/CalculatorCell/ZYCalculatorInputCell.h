//
//  ZYCalculatorInputCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYCalculatorInputCell : ZYTableViewCell
/**
 *  标题
 */
@property(nonatomic,strong)NSString *cellTitle;
/**
 *  修改输入文字 可以被监听信号
 */
@property(nonatomic,strong)NSString *cellDetail;
/**
 *  尾部字符串
 */
@property(nonatomic,strong)NSString *tailText;
/**
 *  输入最长字符
 */
@property(nonatomic,assign)NSInteger maxLength;

#pragma mark - cell关联的 已选 选项
//自动加载选择内容
@property(nonatomic,assign)BOOL hiddenSelecedObj;

@property(nonatomic,assign)NSInteger selecedIndex;

@property(nonatomic,strong)id selecedObj;
//显示类的属性名称
@property(nonatomic,strong)NSString *showKey;

@end
