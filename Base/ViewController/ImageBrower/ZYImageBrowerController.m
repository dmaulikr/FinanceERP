//
//  ZYImageBrowerController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/17.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYImageBrowerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MWPhotoBrowser.h>



@interface ZYImageBrowerController ()<MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) NSMutableArray *thumbs;//缩略图

@end

@implementation ZYImageBrowerController
{
    NSMutableArray *_selections;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    if(self.imageArr.count==0)
    {
        [self loadAssets];
    }
    else
    {
        [self buildUI];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)buildUI
{
    // Browser
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = self.imageArr.count==0;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = self.imageArr.count==0;
    BOOL startOnGrid = self.imageArr.count==0;
    BOOL autoPlayOnAppear = NO;
    
    if(self.imageArr.count==0)
    {
        @synchronized(_assets) {
            NSMutableArray *copy = [_assets copy];
            if (NSClassFromString(@"PHAsset")) {
                // Photos library
                UIScreen *screen = [UIScreen mainScreen];
                CGFloat scale = screen.scale;
                // Sizing is very rough... more thought required in a real implementation
                CGFloat imageSize = MAX(screen.bounds.size.width, screen.bounds.size.height) * 1.5;
                CGSize imageTargetSize = CGSizeMake(imageSize * scale, imageSize * scale);
                CGSize thumbTargetSize = CGSizeMake(imageSize / 3.0 * scale, imageSize / 3.0 * scale);
                for (PHAsset *asset in copy) {
                    [photos addObject:[MWPhoto photoWithAsset:asset targetSize:imageTargetSize]];
                    [thumbs addObject:[MWPhoto photoWithAsset:asset targetSize:thumbTargetSize]];
                }
            } else {
                // Assets library
                for (ALAsset *asset in copy) {
                    MWPhoto *photo = [MWPhoto photoWithURL:asset.defaultRepresentation.url];
                    [photos addObject:photo];
                    MWPhoto *thumb = [MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]];
                    [thumbs addObject:thumb];
                    if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
                        photo.videoURL = asset.defaultRepresentation.url;
                        thumb.isVideo = true;
                    }
                }
            }
        }
    }
    else
    {
        /**
         *  浏览时候 图片异步加载 此处不用单独开线程
         */
        for (ZYImageBrowerImage *image in _imageArr) {
            MWPhoto *photo = [MWPhoto photoWithURL:image.imageUrl];
            [photos addObject:photo];
            MWPhoto *thumb = [MWPhoto photoWithImage:image.image];
            [thumbs addObject:thumb];
            //浏览模式暂时支持图片浏览
//            if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
//                photo.videoURL = asset.defaultRepresentation.url;
//                thumb.isVideo = true;
//            }
        }
    }
    
    self.photos = photos;
    self.thumbs = thumbs;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = YES;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
        browser.title = @"选择照片";
    }
    else
    {
        browser.title = @"浏览";
    }
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:browser];
    [self.view addSubview:navCtl.view];
    [self addChildViewController:navCtl];
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
    if(self.imageArr.count>0)//浏览模式
    {
    }
    else
    {
        if(self.sigleSelected)
        {
            MWPhoto *image = self.thumbs[index];
            if(image.underlyingImage)
            {
                [self selectImage:image.underlyingImage imageUrl:[UIImage saveImage:image.underlyingImage withFileName:[NSString fileName]]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        else
        {
            
        }
        [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    }
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Load Assets

- (void)loadAssets {
    if (NSClassFromString(@"PHAsset")) {
        
        // Check library permissions
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self performLoadAssets];
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self performLoadAssets];
        }
        
    } else {
        
        // Assets library
        [self performLoadAssets];
        
    }
}

- (void)performLoadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    
    // Load
    if (NSClassFromString(@"PHAsset")) {
        
        // Photos library iOS >= 8
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHFetchOptions *options = [PHFetchOptions new];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [_assets addObject:obj];
            }];
            if (fetchResults.count > 0) {
                [self performSelectorOnMainThread:@selector(buildUI) withObject:nil waitUntilDone:NO];
            }
        });
        
    } else {
        
        // Assets Library iOS < 8
        _ALAssetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // Run in the background as it takes a while to get all assets from the library
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
            NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
            
            // Process assets
            void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                    if ([assetType isEqualToString:ALAssetTypePhoto] || [assetType isEqualToString:ALAssetTypeVideo]) {
                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                        NSURL *url = result.defaultRepresentation.url;
                        [_ALAssetsLibrary assetForURL:url
                                          resultBlock:^(ALAsset *asset) {
                                              if (asset) {
                                                  @synchronized(_assets) {
                                                      [_assets addObject:asset];
                                                      if (_assets.count == 1) {
                                                          // Added first asset so reload data
                                                          [self performSelectorOnMainThread:@selector(buildUI) withObject:nil waitUntilDone:NO];
                                                      }
                                                  }
                                              }
                                          }
                                         failureBlock:^(NSError *error){
                                             NSLog(@"operation was not successfull!");
                                         }];
                        
                    }
                }
            };
            
            // Process groups
            void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
                if (group != nil) {
                    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                    [assetGroups addObject:group];
                }
            };
            
            // Process!
            [_ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                            usingBlock:assetGroupEnumerator
                                          failureBlock:^(NSError *error) {
                                              NSLog(@"There is an error");
                                          }];
            
        });
        
    }
    
}
- (void)selectImage:(UIImage*)image imageUrl:(NSURL*)imageUrl{}
- (RACSignal*)sigleSelecedSignal
{
    if(_sigleSelecedSignal==nil)
    {
        _sigleSelecedSignal = [self rac_signalForSelector:@selector(selectImage:imageUrl:)];
    }
    return _sigleSelecedSignal;
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

@implementation ZYImageBrowerImage

@end
