//
//  ZYBannerView.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBannerView.h"
#import <YTKNetworkConfig.h>
#import <UIImageView+AFNetworking.h>

@implementation ZYBannerItem
MJCodingImplementation
@end

@interface ZYBannerView ()<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *myTimer;
/**
 *  显示滚动页码
 */
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ZYBannerView
{
    CGFloat SELFWIDTH;///宽度
    CGFloat SELFHEIGHT;///高度
    NSInteger totalNumber;///广告页面总数
    NSInteger currentPage;///当前页面
    ZYCycleStyle cycleStyle;///默认横向滚动 暂时不可改变
    NSMutableArray *bannerImageArray;
}
- (void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    
    SELFWIDTH = FUll_SCREEN_WIDTH;
    SELFHEIGHT = FUll_SCREEN_WIDTH*AD_SCALE;
    totalNumber = bannerArray.count;
    currentPage = 1;
    cycleStyle = ZYCycleStyleHorizontal;
    bannerImageArray = [NSMutableArray array];
    /**
     *  默认滚动间隔5s
     */
    self.timeInterval = 5;
    
    if (cycleStyle == ZYCycleStyleHorizontal) {
        
        self.scrollView.contentSize = CGSizeMake(SELFWIDTH * (totalNumber + 2), 0);
        self.scrollView.contentOffset = CGPointMake(SELFWIDTH, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
    }
    if (cycleStyle == ZYCycleStyleVertical) {
        
        self.scrollView.contentSize = CGSizeMake(0, SELFHEIGHT * (totalNumber + 2));
        self.scrollView.contentOffset = CGPointMake(0,SELFHEIGHT);
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.alwaysBounceVertical = YES;
    }
    
    [self createBannerView:bannerArray WithCycle:cycleStyle];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}
- (void)createBannerView:(NSArray *)bannerArr WithCycle:(ZYCycleStyle)style {
    
    if (style == ZYCycleStyleHorizontal) {
        for (NSInteger i = 0; i < (totalNumber + 2); i++) {
            
            
            UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SELFWIDTH, 0, SELFWIDTH, SELFHEIGHT)];
            bannerImageView.tag = i;
            bannerImageView.clipsToBounds = YES;
            bannerImageView.backgroundColor = [UIColor whiteColor];
            bannerImageView.userInteractionEnabled = YES;
            bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
            UILabel *loopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SELFWIDTH, SELFHEIGHT)];
            loopLabel.textColor = [UIColor brownColor];
            loopLabel.textAlignment = NSTextAlignmentCenter;
            loopLabel.userInteractionEnabled = YES;
            loopLabel.font = [UIFont systemFontOfSize:12];
            [bannerImageView addSubview:loopLabel];
            
            ZYBannerItem *item;
            if (i == 0) {
                item = bannerArr[totalNumber-1];
                
            }else if (i == totalNumber + 1) {
                item = bannerArr[0];
                
            }else {
                item = bannerArr[i-1];
                
            }
            if (item.source == ZYBannerSourceOnlyLocalSource) {
                bannerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",item.imageName]];
            }else if (item.source == ZYBannerSourceOnlyWebSource) {
                if(item.picture_url.length>0)
                {
                    [bannerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,item.picture_url]] placeholderImage:nil];
                }
            }else if (item.source == ZYBannerSourceOnlyTextSource) {
                loopLabel.text = item.title;
            }
            
            [bannerImageArray addObject:bannerImageView];
            [self.scrollView addSubview:bannerImageView];
        }
        self.pageControl.currentPage = 0;
    }
    if (style == ZYCycleStyleVertical) {
        for (NSInteger i = 0; i < (totalNumber + 2); i++) {
            UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * SELFHEIGHT, SELFWIDTH, SELFHEIGHT)];
            bannerImageView.tag = i;
            bannerImageView.userInteractionEnabled = YES;
            bannerImageView.backgroundColor = [UIColor whiteColor];
            UILabel *loopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SELFWIDTH, SELFHEIGHT)];
            loopLabel.textColor = [UIColor brownColor];
            loopLabel.userInteractionEnabled = YES;
            loopLabel.textAlignment = NSTextAlignmentCenter;
            loopLabel.font = [UIFont systemFontOfSize:14];
            [bannerImageView addSubview:loopLabel];
            
            ZYBannerItem *item;
            if (i == 0) {
                item = bannerArr[totalNumber-1];
                
            }else if (i == totalNumber + 1) {
                item = bannerArr[0];
                
            }else {
                item = bannerArr[i-1];
                
            }
            if (item.source == ZYBannerSourceOnlyLocalSource) {
                bannerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",item.imageName]];
            }else if (item.source == ZYBannerSourceOnlyWebSource) {
                if(item.picture_url.length>0)
                {
                    [bannerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,item.picture_url]] placeholderImage:nil];
                }
            }else if (item.source == ZYBannerSourceOnlyTextSource) {
                loopLabel.text = item.title;
            }
            
            [bannerImageArray addObject:bannerImageView];
            [self.scrollView addSubview:bannerImageView];
        }
    }
    
    
    
    if (totalNumber > 1) {
        [self setupTimer:self.timeInterval];
    }
}
#pragma mark - get方法

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELFWIDTH, SELFHEIGHT)];
        /**<  如果使用者没有设置这些属性,默认属性   **/
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - LazyLoad
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = totalNumber;
        _pageControl.userInteractionEnabled = YES;
        CGSize size = [_pageControl sizeForNumberOfPages:totalNumber];
        _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x, SELFHEIGHT - size.height / 2);
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"f9bf00"];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark - 定时器

- (void)setupTimer:(CGFloat)timeInterval {
    self.myTimer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSDefaultRunLoopMode];
}

- (void)scrollAction {
    
    if (currentPage % (totalNumber + 1) != 0 || currentPage == 1) {
        if (cycleStyle == ZYCycleStyleHorizontal) {
            [self.scrollView setContentOffset:CGPointMake(SELFWIDTH * (currentPage + 1), 0) animated:YES];
        }else if (cycleStyle == ZYCycleStyleVertical) {
            [self.scrollView setContentOffset:CGPointMake(0, SELFHEIGHT * (currentPage + 1)) animated:YES];
        }
    }else if (currentPage % (totalNumber + 1) == 0 && currentPage != 1) {
        if (cycleStyle == ZYCycleStyleHorizontal) {
            [self.scrollView setContentOffset:CGPointMake(SELFWIDTH, 0) animated:YES];
        }else if (cycleStyle == ZYCycleStyleVertical) {
            [self.scrollView setContentOffset:CGPointMake(0, SELFHEIGHT) animated:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (cycleStyle == ZYCycleStyleHorizontal) {
        currentPage = (NSInteger)((scrollView.contentOffset.x) / SELFWIDTH);
        self.pageControl.currentPage = currentPage - 1;
        CGFloat yourPage = (CGFloat)(scrollView.contentOffset.x) / SELFWIDTH;
        if (yourPage == (totalNumber + 1)) {
            [scrollView setContentOffset:CGPointMake(SELFWIDTH, 0) animated:NO];
        }
        if (yourPage == 0) {
            [scrollView setContentOffset:CGPointMake(totalNumber * SELFWIDTH, 0) animated:NO];
        }
    }else if (cycleStyle == ZYCycleStyleVertical){
        /**<  存在的问题，需要进行加1才能使scrollview loop起来，可能存在误差   **/
        currentPage = (NSInteger)((scrollView.contentOffset.y + 1) / SELFHEIGHT);
        CGFloat horiPage = (scrollView.contentOffset.y) / SELFHEIGHT;
        if (horiPage == totalNumber + 1) {
            [scrollView setContentOffset:CGPointMake(0, SELFHEIGHT) animated:NO];
        }
        if (horiPage == 0) {
            [scrollView setContentOffset:CGPointMake(0, totalNumber * SELFHEIGHT) animated:NO];
        }
    }
}

/**
 *  监测到有拖动的动作时，暂停定时器。
 *
 *  @param scrollView 当前scrollView
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.myTimer && totalNumber > 1) {
        [self.myTimer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.timeInterval > 0 && totalNumber > 1) {
        [self setupTimer:self.timeInterval];
    }else {
        if (totalNumber > 1) {
            [self setupTimer:5.0];
        }
    }
}
#pragma mark - layout
- (RACSignal *)bannerTapSignal
{
    if(_bannerTapSignal==nil)
    {
        _bannerTapSignal = [[self rac_signalForSelector:@selector(tapSignal:)] map:^id(RACTuple *value) {
            return [value first];
        }];
    }
    return _bannerTapSignal;
}
#pragma mark - 点击事件
- (void)tapAction
{
    if(self.bannerTapSignal)
    {
        [self tapSignal:currentPage-1];
    }
}
- (void)tapSignal:(NSInteger)index{}
@end
