//
//  ZYSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"



@implementation ZYSections

- (instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.title = title;
        [self blendMethed];
    }
    return self;
}
- (void)blendMethed
{
    _searchByDataSourceSignal = [self rac_signalForSelector:@selector(cellSearch:withDataSource:showKey:)];
    _searchBySignalSignal = [self rac_signalForSelector:@selector(cellSearch:withDataSourceSignal:showKey:)];
    _pickerByDataSourceSignal = [self rac_signalForSelector:@selector(cellPicker:withDataSource:showKey:)];
    _pickerBySignalSignal = [self rac_signalForSelector:@selector(cellPicker:withDataSourceSignal:showKey:)];
    _nextStepSignal = [self rac_signalForSelector:@selector(cellNextStep:sender:)];
    _lastStepSignal = [self rac_signalForSelector:@selector(cellLastStep)];
    _datePickerSignal = [self rac_signalForSelector:@selector(cellDatePicker:onlyFutura:)];
    _showSectionSignal = [self rac_signalForSelector:@selector(showSection:sectionIndex:)];
}
- (void)cellSearch:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey{}
- (void)cellSearch:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey{}


- (void)cellPicker:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey{}
- (void)cellPicker:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey{}
//onlyFutura 只显示将来 默认显示全部
- (void)cellDatePicker:(ZYTableViewCell*)cell onlyFutura:(BOOL)onlyFutura{}

- (void)cellNextStep:(NSString*)error sender:(id)sender{}
- (void)cellLastStep{}


- (void)showSection:(BOOL)show sectionIndex:(NSInteger)index{}
@end
