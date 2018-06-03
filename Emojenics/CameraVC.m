//
//  CameraVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 22/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "CameraVC.h"
#import "EmojenicsGenerateVC.h"
#import "PreviewVC.h"
#import "SVProgressHUD.h"

@interface CameraVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isOpenGallery;
}
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *CrossBtn;
@property (weak, nonatomic) IBOutlet UIImageView *CrossImg;

@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isOpenGallery=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)CrossBtnPress:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)GalaryBtnPressed:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
    }
    else{
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
//    EmojenicsGenerateVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmojenicsGenerateVC"];
//
//    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)openImagePicker:(id)sender
{
   
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Device has no camera."] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.allowsEditing = NO;
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        imagePickerController.delegate = self;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        }
        else{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    UIImage* image1 = [UIImage imageWithCGImage:image.CGImage
                                                scale:image.scale
                                          orientation:UIImageOrientationDownMirrored];
    UIImage* image2 =  [UIImage imageWithCGImage:image1.CGImage
                                           scale:image1.scale
                                     orientation:UIImageOrientationLeftMirrored];

    
    self.profileImageView.image = image2;
    UIImage * imageSend=image2;
    [SVProgressHUD showWithStatus:@"Emojenizing..." maskType:SVProgressHUDMaskTypeBlack];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD dismiss];
    PreviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviewVC"];
    vc.ReciveImage=imageSend;
    [self.navigationController pushViewController:vc animated:YES];

}



@end
