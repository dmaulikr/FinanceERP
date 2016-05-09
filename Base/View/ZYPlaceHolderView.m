//
//  ZYPlaceHolderView.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYPlaceHolderView.h"

@implementation ZYPlaceHolderView
{
    UIImageView *imageView;
    UILabel *label;
}
- (instancetype)initWithFrame:(CGRect)frame type:(ZYPlaceHolderViewType)type
{
    self = [super init];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        NSString *imageName = nil;
        NSString *tip = nil;
        switch (type) {
            case ZYPlaceHolderViewTypeNoData:
            {
                imageName = @"hint_no_data";
                tip = @"暂无数据";
            }
                break;
            case ZYPlaceHolderViewTypeNoSearchData:
            {
                imageName = @"hint_search_no_data";
                tip = @"没有搜索到您要的结果，请更换条件再试哦";
            }
                break;
            case ZYPlaceHolderViewTypeNoNet:
            {
                imageName = @"hint_no_connect";
                tip = @"网络好像开了小差，请下拉刷新重试";
            }
                break;
            default:
                break;
        }
        UIImage *image = [UIImage imageNamed:imageName];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width-image.size.width)/2.f, (height-image.size.height)/2.f-50, image.size.width, image.size.height)];
        imageView.image = image;
        [self addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.Y+imageView.height+GAP, width, 20)];
        label.text = tip;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = TITLE_COLOR;
        [self addSubview:label];
        
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    label.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
