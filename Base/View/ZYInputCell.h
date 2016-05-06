//
//  ZYInputCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYInputCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;

@property(nonatomic,strong)NSString *cellText;

@property(nonatomic,strong)NSString *cellPlaceHolder;
@property(nonatomic,strong)NSString *cellTailText;

#pragma mark - 输入限制

@property(nonatomic,assign)BOOL onlyFloat;
@property(nonatomic,assign)BOOL onlyInt;
@property(nonatomic,assign)BOOL onlyCustom;///自定义输入内容
@property(nonatomic,strong)NSString *customInput;///制定只能输入哪些字符
/**
 *  输入最长字符
 */
@property(nonatomic,assign)NSInteger maxLength;

@property(nonatomic,assign)UIKeyboardType keyboardType;

@property(nonatomic,assign)BOOL cellNullable;/// 默认不能为空


#pragma mark - cell关联的 已选 选项
//自动加载选择内容
@property(nonatomic,assign)BOOL hiddenSelecedObj;

@property(nonatomic,assign)NSInteger selecedIndex;

@property(nonatomic,strong)id selecedObj;
//显示类的属性名称
@property(nonatomic,strong)NSString *showKey;

#pragma mark - cell输入错误信息
@property(nonatomic,strong)NSString *cellRegular;
@property(nonatomic,strong)NSString *cellError;

- (NSString*)checkInput:(BOOL)checkInput;
@end
