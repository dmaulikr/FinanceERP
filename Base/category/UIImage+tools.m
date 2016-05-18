//
//  UIImage+tools.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "UIImage+tools.h"

@implementation UIImage (tools)
+ (NSURL*)saveImage:(UIImage*)image withFileName:(NSString*)fileName
{
    NSData* imageData = UIImageJPEGRepresentation(image, 0.3);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"uploadFile"];
    BOOL isDir = NO;
    BOOL isCreated = [[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory isDirectory:&isDir];
    if (isCreated == NO || isDir == NO) {
        NSError* error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (success == NO)
            NSLog(@"create dir error: %@", error.debugDescription);
    }
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    [imageData writeToFile:fullPathToFile atomically:YES];
    return [NSURL fileURLWithPath:fullPathToFile];
}
@end
