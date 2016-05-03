//
//  ZYFadeTransion.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFadeTransion.h"

@implementation ZYFadeTransion
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _animationDuration==0?0.3f:_animationDuration;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if(self.animation)
    {
        UIView *container = [transitionContext containerView];
        UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        toController.view.frame = [transitionContext finalFrameForViewController:toController];
        toController.view.alpha = 0;
        [container addSubview:toController.view];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else
    {
        UIView *container = [transitionContext containerView];
        UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        toController.view.frame = [transitionContext finalFrameForViewController:toController];
        [container addSubview:toController.view];

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
}
@end
