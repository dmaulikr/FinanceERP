//
//  ZYPlaceHolderView.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZYPlaceHolderViewTypeNoData = 0,
    ZYPlaceHolderViewTypeNoNet,
    ZYPlaceHolderViewTypeNoSearchData,
} ZYPlaceHolderViewType;

@interface ZYPlaceHolderView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(ZYPlaceHolderViewType)type;

@property(nonatomic,strong)NSString *title;
@end
