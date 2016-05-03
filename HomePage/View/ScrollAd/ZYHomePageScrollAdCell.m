//
//  ZYHomePageScrollAdCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageScrollAdCell.h"


@interface ZYHomePageScrollAdCell ()

//@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (strong, nonatomic) ZYBannerView *bannerView;

@end

@implementation ZYHomePageScrollAdCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (RACSignal *)bannerTapSignal
{
    return self.bannerView.bannerTapSignal;
}

- (void)setBannerArr:(NSArray*)bannerArr
{
    _bannerArr = bannerArr;
    [self.bannerView setBannerArray:bannerArr];
}
+ (CGFloat)defaultHeight
{
    return FUll_SCREEN_WIDTH * AD_SCALE;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYHomePageScrollAdCell defaultHeight])];
        [self addSubview:_bannerView];
    }
    return self;
}

@end
