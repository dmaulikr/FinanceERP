//
//  ZYSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYTableViewCell.h"
#import "ZYSection.h"
#import "ZYInputCell.h"
#import "ZYSelectCell.h"
#import "ZYSegmentedCell.h"
#import "ZYSingleButtonCell.h"
#import "ZYDoubleButtonCell.h"
#import "ZYSeveralButtonCell.h"
@interface ZYSections : NSObject

@property(nonatomic,strong)NSArray *sections;
@property(nonatomic,strong)NSString *title;

- (void)cellSearch:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey;
- (void)cellSearch:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey;


- (void)cellPicker:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey;
- (void)cellPicker:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey;

- (void)cellDatePicker:(ZYTableViewCell*)cell onlyFutura:(BOOL)onlyFutura;

- (void)cellNextStep:(NSString*)error;
- (void)cellLastStep;
//折叠section
- (void)showSection:(BOOL)show sectionIndex:(NSInteger)index;
//初始化
- (instancetype)initWithTitle:(NSString*)title;

@property(nonatomic,strong)RACSignal *searchByDataSourceSignal;
@property(nonatomic,strong)RACSignal *searchBySignalSignal;

@property(nonatomic,strong)RACSignal *pickerByDataSourceSignal;
@property(nonatomic,strong)RACSignal *pickerBySignalSignal;

@property(nonatomic,strong)RACSignal *nextStepSignal;
@property(nonatomic,strong)RACSignal *lastStepSignal;

@property(nonatomic,strong)RACSignal *datePickerSignal;

@property(nonatomic,strong)RACSignal *showSectionSignal;
@end
