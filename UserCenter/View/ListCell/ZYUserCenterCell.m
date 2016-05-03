//
//  ZYUserCenterCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterCell.h"

@interface ZYUserCenterCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end

@implementation ZYUserCenterCell

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellLabel.text = cellTitle;
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _cellImageView.image = [UIImage imageNamed:imageName];
}
@end
