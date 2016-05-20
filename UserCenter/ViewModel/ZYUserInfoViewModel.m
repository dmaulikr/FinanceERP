//
//  ZYUserInfoViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserInfoViewModel.h"

@implementation ZYUserInfoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,[ZYUser user].photo_url]];
    }
    return self;
}
- (void)uploadHeadImage
{
    ZYUploadFileRequest *request = [[ZYUploadFileRequest alloc] init];
    request.image = self.headImage;
    request.userId = [ZYUser user].pid;
    request.imageUrl = self.headImageUrl;
    self.headImageUploadSuccess = NO;
    [[[ZYRoute route] uploadFile:request] subscribeNext:^(NSNumber *fileID) {
        self.fileID = fileID.longLongValue;
        [self blendHeadImage];
    } error:^(NSError *error) {
        self.headImageUploadSuccess = NO;
        self.loading = NO;
        self.error = @"头像上传失败，请重试";
    } completed:^{
        
    }];
}
- (void)blendHeadImage
{
    ZYBlendHeadImageRequest *request = [ZYBlendHeadImageRequest request];
    request.user_id = [ZYUser user].pid;
    request.file_id = self.fileID;
    [[[ZYRoute route] blendHeadImageRequest:request] subscribeNext:^(id x) {
        self.headImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,x]];
        [ZYUser user].photo_url = x;
        self.headImageUploadSuccess = YES;
        self.loading = NO;
    } error:^(NSError *error) {
        self.headImageUploadSuccess = NO;
        self.loading = NO;
        self.error = @"头像上传失败，请重试";
    } completed:^{
        
    }];
}

- (NSArray*)titleArr
{
    return @[@"工号",@"姓名",@"联系电话",@"部门",@"职位"];
}
@end
