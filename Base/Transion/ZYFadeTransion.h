//
//  ZYFadeTransion.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFadeTransion : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)float animation;
@property(nonatomic,assign)float animationDuration;
@end
