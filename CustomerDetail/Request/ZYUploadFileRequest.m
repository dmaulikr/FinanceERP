//
//  ZYUploadFileRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUploadFileRequest.h"

@implementation ZYUploadFileRequest
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/uploadFile.action?userId=%ld",self.userId];
}
- (AFConstructingBlock)constructingBodyBlock {
    if(self.imageUrl==nil)
        return nil;
    
    return ^(id<AFMultipartFormData> formData) {
        NSString *name = @"headImage.jpeg";
        NSString *formKey = @"offlineMeetingFile";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileURL:self.imageUrl name:formKey fileName:name mimeType:type error:nil];
    };
}
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{};
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
@end
