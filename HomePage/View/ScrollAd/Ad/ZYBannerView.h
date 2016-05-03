//
//  ZYBannerView.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AD_SCALE 0.33

typedef NS_ENUM(NSInteger, ZYCycleStyle) {
    /**
     *  横向
     */
    ZYCycleStyleHorizontal = 0,
    /**
     *  纵向
     */
    ZYCycleStyleVertical = 1,
};

typedef NS_ENUM(NSInteger, ZYBannerSource) {
    /**
     *  图片来自本地
     */
    ZYBannerSourceOnlyLocalSource = 1,
    /**
     *  图片来自网络 默认
     */
    ZYBannerSourceOnlyWebSource = 0,
    /**
     *  纯文本
     */
    ZYBannerSourceOnlyTextSource = 2,
};

@interface ZYBannerItem : NSObject

#pragma mark - 网络获取字段

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *picture_url;

@property (nonatomic, assign) NSInteger order_index;

@property (nonatomic, copy) NSString *adv_url;

/**
 *  本地图片名称  用于显示本地图片
 */
@property(nonatomic,strong)NSURL *imageName;
/**
 *  数据类型 来自 网络 本地 还是 纯文本
 */
@property(nonatomic,assign)ZYBannerSource source;

@end

@interface ZYBannerView : UIView

@property (nonatomic, assign) CGFloat timeInterval;

@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, strong) RACSignal *bannerTapSignal;
@end
