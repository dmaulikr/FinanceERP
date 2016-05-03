//
//  ZYNavCenterView.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/27.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYNavCenterView.h"

@interface ZYNavCenterView()

@property(nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation ZYNavCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.frame = CGRectMake(0, 0, 30, 30);
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
        [self addSubview:_activityIndicatorView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return self;
}
+ (instancetype)navCenterView
{
    ZYNavCenterView *navCenterView = [[ZYNavCenterView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    return navCenterView;
}
- (void)setLoading:(BOOL)loading
{
    _loading = loading;
    if(loading)
    {
        [_activityIndicatorView startAnimating];
        _titleLabel.width = self.width-_activityIndicatorView.width;
        _titleLabel.X = _activityIndicatorView.width;
    }
    else
    {
        [_activityIndicatorView stopAnimating];
        _titleLabel.width = self.width;
        _titleLabel.X = 0;
    }
}
- (void)setStatue:(NSString *)statue
{
    _statue = statue;
    _titleLabel.text = statue;
}
@end
