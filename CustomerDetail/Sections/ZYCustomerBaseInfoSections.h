//
//  ZYCustomerBaseInfoSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYCustomerBaseInfoViewModel.h"

@interface ZYCustomerBaseInfoSections : ZYSections

@property(nonatomic,assign)BOOL edit;
@property(nonatomic,strong)NSString *error;

- (void)blendModel:(ZYCustomerBaseInfoViewModel*)model;

- (void)becomeFirstResponder;


@property(nonatomic,strong)RACSignal *headImagePickSignal;

@property(nonatomic,strong)RACSignal *returnSignal;

@property(nonatomic,strong)RACSignal *detailCellPressedSignal;

@end
