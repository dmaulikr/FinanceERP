//
//  ZYBusinessProcessingStateSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYBusinessProcessingStateViewModel.h"
@interface ZYBusinessProcessingStateSections : ZYSections

- (void)blendModel:(ZYBusinessProcessingStatePageModel*)model;

@property(nonatomic,assign)BOOL edit;

@end
