//
//  CreateBugViewController.m
//  Bug
//
//  Created by Tagcare on 15/10/21.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "CreateBugViewController.h"

#import "DNAsset.h"
#import "DNImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>


#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "EBPhotoPagesController.h"
#import "PhotoTweaksViewController.h"

@interface CreateBugViewController ()<DNImagePickerControllerDelegate, PhotoTweaksViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollImageView;
@property(strong,nonatomic)UIImageView * bugImage;


@property (nonatomic, strong) NSMutableArray * arrImage;
@property (nonatomic, strong) NSMutableArray * assetsArray;

@end

@implementation CreateBugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrImage = [NSMutableArray arrayWithCapacity:5];
    self.assetsArray = [NSMutableArray arrayWithCapacity:5];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    //限制数组里最多9个元素
    NSRange range = NSMakeRange(9, self.arrImage.count - 9);
    if (self.arrImage.count>9) {
        [self.arrImage removeObjectsInRange:range];
    }
    for (int i = 0; i<self.arrImage.count; i++) {
        self.bugImage = [[UIImageView alloc]initWithFrame:CGRectMake(110*i, 0, 105, 105)];
        
        NSDictionary * d = self.arrImage[i];
        NSData * data = d[@"imageString"];
        UIImage * image = [UIImage imageWithData:data];
        self.bugImage.image =image ;
        [self.scrollImageView addSubview:self.bugImage];
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.bugImage addGestureRecognizer:tap];
        self.bugImage.tag = i;
        self.bugImage.userInteractionEnabled = YES;
        
    }
    
    self.scrollImageView.contentSize =CGSizeMake(110*self.arrImage.count, 0);
    if (self.arrImage.count>3) {
        self.scrollImageView.contentOffset = CGPointMake(110+self.scrollImageView.contentOffset.x,0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didClickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didClickPhotoButtonAction:(id)sender {
    
    UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"take a photo");
        [self takePhotoFromCamera];
    }];
    UIAlertAction * selectPhotoAction = [UIAlertAction actionWithTitle:@"select photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"select photo");
        [self selectPhotoFromLibrary];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:takePhotoAction];
    [alertController addAction:selectPhotoAction];
}

#pragma mark - 照相
-(void)takePhotoFromCamera{
    
    if(self.arrImage.count>8){
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerControllerDelegate
//get picture from camera or library
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    

        //得到图片
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        UIImage * i=  [self fixOrientation:image];
        NSData *a= UIImagePNGRepresentation(i);
        NSDictionary * dic = @{@"imageString":a};
        
        [self.arrImage addObject:dic];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    
    
}

#pragma mark - 选择图片
-(void)selectPhotoFromLibrary{
    if (self.arrImage.count>8) {
        return;
    }
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];

}

#pragma mark - DNImagePickerControllerDelegate
- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage{
    
    self.assetsArray = [NSMutableArray arrayWithArray:imageAssets];
    
    for (int i = 0; i<imageAssets.count; i++) {
        
        DNAsset *dnasset = imageAssets[i];
        
        ALAssetsLibrary *lib = [ALAssetsLibrary new];
        __weak typeof(self) weakSelf = self;
        [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
            if (asset) {
                [weakSelf asset:asset count:i];
            }else{
                // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
                [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                   usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                                       [group enumerateAssetsWithOptions:NSEnumerationReverse
                                                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                                  
                                                                  if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url]){
                                                                      [weakSelf asset:result count:i];
                                                                      *stop = YES;
                                                                  }
                                                              }];
                                   }
                                 failureBlock:^(NSError *error){
                                     
                                     
                                 }];
            }
            
        } failureBlock:^(NSError *error){
            
        }];
        
    }
}

- (void)asset:(ALAsset *)asset count:(int)count{
    
    NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
    UIImageOrientation orientation = UIImageOrientationUp;
    if (orientationValue != nil) {
        orientation = [orientationValue intValue];
    }
    
    UIImage * image = [UIImage imageWithCGImage:asset.thumbnail];
    NSData *a= UIImagePNGRepresentation(image);
    NSDictionary * dic = @{@"imageString":a};
    
    [self.arrImage addObject:dic];
    
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//避免照片太大 自动翻转90度
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

////删除照片
-(void)tap:(UITapGestureRecognizer*)send{
    
//    [self alertView:sender.view.tag];
    
//    EBPhotoPagesController *photoPagesController = [[EBPhotoPagesController alloc] initWithDataSource:self delegate:self];
//    [self presentViewController:photoPagesController animated:YES completion:nil];
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSDictionary * d = self.assetsArray[0];
    NSData * data = d[@"imageString"];
    UIImage * image = [UIImage imageWithData:data];
    PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:image];
    photoTweaksViewController.delegate = self;
    photoTweaksViewController.autoSaveToLibray = YES;
    
    [self.navigationController pushViewController:photoTweaksViewController animated:YES];
    
}

#pragma mark - PhotoTweaksViewController代理方法
- (void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage
{
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)photoTweaksControllerDidCancel:(PhotoTweaksViewController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];
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
