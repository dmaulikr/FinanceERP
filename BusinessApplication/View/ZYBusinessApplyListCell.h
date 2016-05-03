//
//  ZYBusinessApplyListCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYBusinessApplyListCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellImageName;
@property(nonatomic,strong)NSString *cellTitleText;
@property(nonatomic,strong)NSString *cellSubTitleText;
@property(nonatomic,strong)RACSignal *cellButtonPressSignal;
@end
