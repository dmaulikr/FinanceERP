//
//  ZYTabBarController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTabBarController.h"
#import "ZYTabBar.h"
#import "ZYFadeTransion.h"
#import "ZYLoginController.h"
#import "ZYUser.h"
@interface ZYTabBarController ()<UIViewControllerTransitioningDelegate>

/**
 *  自定义tabBar
 */
@property(nonatomic,strong)ZYTabBar *tabBarView;

@end

@implementation ZYTabBarController
{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZYFadeTransion *transion;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    transion = [[ZYFadeTransion alloc] init];
    
    _tabBarView = [[ZYTabBar alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:_tabBarView];
    
    __weak typeof(self) weakSelf = self;
    [_tabBarView.tabBarSignal subscribeNext:^(NSNumber *index) {
        [weakSelf setSelectedIndex:[index longLongValue]];
    }];
}
- (RACSignal*)tabBarSignal
{
    return _tabBarView.tabBarSignal;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"login"])
    {
        ZYLoginController *controller = [segue destinationViewController];
        
        controller.transitioningDelegate = self;
    }
}
#pragma mark - 转场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return transion;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    transion.animation = YES;
    transion.animationDuration = 1.f;
    return transion;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}

@end
