//
//  AppDelegate.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYHomePageViewController.h"
#import <YTKNetworkConfig.h>
#import "ZYStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /**
     *  全局 ui设置
     */
    [self appearance:application];
    return YES;
}
- (void)appearance:(UIApplication*)app
{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:88.f];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    //基础路径
    [YTKNetworkConfig sharedInstance].baseUrl = [NSString stringWithFormat:@"%@BMS/mobileApi",HOST];
    
    //复制数据库到 document文件下  便于读写
    [ZYStore copyDBWhenNotExit];
//    [[[ZYStore alloc] init] creatData];
}
@end
