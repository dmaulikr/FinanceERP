//
//  ZYSelectListViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSelectListViewModel.h"

@interface ZYSelectListViewModel()

@property(nonatomic,assign)ZYCalculatorValueModel *model;

@end

@implementation ZYSelectListViewModel

+ (instancetype)viewModelWith:(ZYCalculatorValueModel*)model
{
    ZYSelectListViewModel *viewModel = [[ZYSelectListViewModel alloc] init];
    viewModel.model = model;
    return viewModel;
}
- (void)setModel:(ZYCalculatorValueModel *)model
{
    _model = model;
    
    LKDBHelper *helper = [ZYCalculatorValueModel getUsingLKDBHelper];
//    @weakify(self);
//    [helper search:[ZYCalculatorValueModel class] where:@{@"selectListType":@(model.selectListType),@"calculatorType":@(model.calculatorType),@"computerType":@(model.computerType)} orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
//        @strongify(self);
//        /**
//         *  子线程查询 通知主线程
//         */
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.dataSource = array;
//        });
//    }];
}
- (NSString*)contentForItem:(NSInteger)index
{
    if(index>=self.dataSource.count)
        return nil;
    
    return [(ZYValueModel*)self.dataSource[index] content];
}


@end
