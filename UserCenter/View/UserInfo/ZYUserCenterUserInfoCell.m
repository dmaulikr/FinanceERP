//
//  ZYUserCenterUserInfoCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterUserInfoCell.h"
#import <UIImageView+AFNetworking.h>

@interface ZYUserCenterUserInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;

@end

@implementation ZYUserCenterUserInfoCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_headImageView roundRectWith:_headImageView.width/2.f];
}

+ (CGFloat)defaultHeight
{
    return 130.f;
}

- (void)setUser:(ZYUser *)user
{
    _user = user;
    if(user)
    {
        [_headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,user.photo_url]] placeholderImage:[UIImage imageNamed:@"headImage"]];
        _userNameLabel.text = user.real_name;
        _userInfoLabel.text = [NSString stringWithFormat:@"%@ %@",user.org_name,user.job_title];
    }
    else
    {
        _headImageView.image = [UIImage imageNamed:@"headImage"];
        _userNameLabel.text = @"未登陆";
        _userInfoLabel.text = @"";
    }
}
@end
