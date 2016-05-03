//
//  ZYHomePageViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYBannerView.h"

@interface ZYHomePageViewModel : ZYViewModel
/**
 *  nav 中间状态显示
 */
@property(nonatomic,assign)BOOL navLoading;
@property(nonatomic,strong)NSString *navState;
/**
 *  是否需要手动登陆
 */
@property(nonatomic,assign)BOOL needShowLoginController;
/**
 *  广告数组
 */
@property(nonatomic,strong)NSArray *bannerArr;
/**
 *  签到天数
 */
@property(nonatomic,assign)NSInteger checkInDays;
/**
 *  是否签到
 */
@property(nonatomic,assign)BOOL hasCheckIn;
/**
 *  签到错误
 */
@property(nonatomic,strong)NSString *error;
/**
 *  事件
 */
@property(nonatomic,strong)NSArray *eventArr;


/**
 *  请求广告
 */
- (void)requestBannerArr:(ZYUser*)user;
/**
 *  请求签到天数
 */
- (void)requestCheckInDays:(ZYUser*)user;
- (void)requestCheckIn:(ZYUser*)user;
/**
 *  请求注意事项
 */
- (void)requestWarningEvent:(ZYUser*)user;


- (void)autoLogin;

- (void)loadCache;
@end
