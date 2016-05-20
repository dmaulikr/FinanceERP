//
//  ZYUserInfoHeadCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserInfoHeadCell.h"
#import <UIButton+AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface ZYUserInfoHeadCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation ZYUserInfoHeadCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.headImage roundRectWith:self.headImage.height/2.f];
}
- (void)setHeadImageURL:(NSURL *)headImageURL
{
    _headImageURL = headImageURL;
    [_headImage setImageWithURL:headImageURL placeholderImage:[UIImage imageNamed:@"headImage"]];
}
+ (CGFloat)defaultHeight
{
    return 80;
}
@end
