//
//  ZYNavCenterView.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/27.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNavCenterView : UIView

@property(nonatomic,assign)BOOL loading;
@property(nonatomic,strong)NSString *statue;


+ (instancetype)navCenterView;
@end
