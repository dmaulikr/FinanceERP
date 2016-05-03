//
//  ZYHomePageScrollAdCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"
#import "ZYBannerView.h"

@interface ZYHomePageScrollAdCell : ZYTableViewCell

@property(nonatomic,strong)NSArray *bannerArr;

@property (nonatomic, strong) RACSignal *bannerTapSignal;

@end
