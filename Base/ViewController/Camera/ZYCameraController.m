//
//  ZYCameraController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCameraController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface ZYCameraController ()<UIImagePickerControllerDelegate , UINavigationControllerDelegate>{
    UIImagePickerController   *  _cameraVC;
}

@end

@implementation ZYCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}
- (void)buildUI{
    
//    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied)
//    {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法启动相册" message:@"请为金融ERP开启相册权限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"设置",@"取消", nil];
//            [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index) {
//                if(index.longLongValue==0)
//                {
//                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                    
//                    if([[UIApplication sharedApplication] canOpenURL:url]) {
//                        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                        [[UIApplication sharedApplication] openURL:url];
//                    }
//                    
//                }
//                if(index.longLongValue==1)
//                {
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }
//            }];
//            [alert show];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法启动相机" message:@"请为金融ERP开启相册权限:手机设置->隐私->相册->金融ERP(打开)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index) {
//                if(index.longLongValue==0)
//                {
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }
//            }];
//            [alert show];
//        }
//    }
    
    
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法启动相机" message:@"请为金融ERP开启相机权限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"设置",@"取消", nil];
            [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index) {
                if(index.longLongValue==0)
                {
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                    
                }
                if(index.longLongValue==1)
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法启动相机" message:@"请为金融ERP开启相机权限:手机设置->隐私->相机->金融ERP(打开)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index) {
                if(index.longLongValue==0)
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            [alert show];
        }
    }
    
    _cameraVC = [[UIImagePickerController alloc]init];
    _cameraVC.delegate = self;
    _cameraVC.allowsEditing = YES;
    _cameraVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    _cameraVC.view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_cameraVC.view];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    @weakify(self)
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self)
        if(image != nil){
            [self selectImage:image imageUrl:[UIImage saveImage:image withFileName:[NSString fileName]]];
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage  * image = info[@"UIImagePickerControllerOriginalImage"];
    @weakify(self)
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self)
        if(image != nil){
            [self selectImage:image imageUrl:[UIImage saveImage:image withFileName:[NSString fileName]]];
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)selectImage:(UIImage*)image imageUrl:(NSURL*)imageUrl{}
- (RACSignal*)imagePickerSignal
{
    if(_imagePickerSignal==nil)
    {
        _imagePickerSignal = [self rac_signalForSelector:@selector(selectImage:imageUrl:)];
    }
    return _imagePickerSignal;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
