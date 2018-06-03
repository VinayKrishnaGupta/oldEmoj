//
//  EmojenicsList.m
//  Emojenics
//
//  Created by Elagoon 1 on 19/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "EmojenicsList.h"
#import "CustomizeVC.h"
#import "PreviewVC.h"

@interface EmojenicsList () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIImage *filteredImage;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EmojenicsList

- (void)viewDidLoad {
    [super viewDidLoad];
    filteredImage = [[UIImage alloc]init];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
     NSLog(@"Image Size %@", _clickedImage);
    [self ApplyGPUImageFilterOne];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ApplyGPUImageNEwFilters
{
    //    UIImage *inputImage = [UIImage imageNamed:@"samplemen"];
    
    
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_clickedImage];
    
    GPUImageGaussianBlurFilter *filter1 = [[GPUImageGaussianBlurFilter alloc] init];
    //    filter1.blurRadiusInPixels = 3;
    //    filter1.blurPasses = 2;
    
    
    GPUImageBilateralFilter *filter2 = [[GPUImageBilateralFilter alloc] init];
    filter2.distanceNormalizationFactor = 4;
    filter2.texelSpacingMultiplier = 4;
    [filter1 addTarget:filter2];
    
    GPUImagePinchDistortionFilter *filter3 = [[GPUImagePinchDistortionFilter alloc]init];
    filter3.radius = 1;
    filter3.scale = -0.4    ;
    filter3.center = CGPointMake(0.48, 0.15);
    [filter2 addTarget:filter3];
    
    
    GPUImageToonFilter *filter4 = [[GPUImageToonFilter alloc] init];
    filter4.threshold = 0.5;
    filter4.quantizationLevels = 20;
    [filter3 addTarget:filter4];
    
    GPUImageWhiteBalanceFilter *filter5 = [[GPUImageWhiteBalanceFilter alloc] init];
    filter5.temperature = 4500;
    filter5.tint = 50;
    
    [filter4 addTarget:filter5];
    
    
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc]init];
    [groupFilter addTarget:filter1];
    [groupFilter addTarget:filter2];
    [groupFilter addTarget:filter3];
    [groupFilter addTarget:filter4];
    [groupFilter addTarget:filter5];
    
    [groupFilter setInitialFilters:[NSArray arrayWithObjects:filter1, nil]];
    [groupFilter setTerminalFilter:filter5];
    
    [groupFilter useNextFrameForImageCapture];
    [stillImageSource addTarget:groupFilter];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [groupFilter imageFromCurrentFramebuffer];
    
    // _filteredImageView.image = currentFilteredVideoFrame;
}

-(void)ApplyGPUImageFilterOne
{
    //    UIImage *inputImage = [UIImage imageNamed:@"samplemen.png"];
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_clickedImage];
    //    GPUImageToonFilter *filter1 = [[GPUImageToonFilter alloc] init];
    //    filter1.threshold = 0.8;
    //    filter1.quantizationLevels = 20;
    //
    //GPUImageSmoothToonFilter
    GPUImageToonFilter *filter1 = [[GPUImageToonFilter alloc] init];
    filter1.threshold = 0.8;
    filter1.quantizationLevels = 20;
    //  filter1.blurRadiusInPixels = 2.5;
    
    GPUImageSaturationFilter *filter2 = [[GPUImageSaturationFilter alloc] init];
    filter2.saturation = 1.5;
    
    [filter1 addTarget:filter2];
    
    //    GPUImageGlassSphereFilter *filter3 = [[GPUImageGlassSphereFilter alloc] init];
    //    filter3.radius = 0.4;
    //    [filter2 addTarget:filter3];
    
    GPUImagePinchDistortionFilter *filter3 = [[GPUImagePinchDistortionFilter alloc]init];
    filter3.radius = 1;
    filter3.scale = -0.4    ;
    filter3.center = CGPointMake(0.48, 0.15);
    [filter2 addTarget:filter3];
    //    //GPUImageZoomBlurFilter
    //    GPUImageZoomBlurFilter *filter4 = [[GPUImageZoomBlurFilter alloc] init];
    //
    //    [filter3 addTarget:filter4];
    //
    //
    //    GPUImageWhiteBalanceFilter *filter4 = [[GPUImageWhiteBalanceFilter alloc] init];
    //    filter4.temperature = 4900;
    //    filter4.tint = 100;
    //    [filter3 addTarget:filter4];
    
    GPUImageGammaFilter *filter4 = [[GPUImageGammaFilter alloc] init];
    filter4.gamma = 1.7;
    //  filter4.brightness = 0.5;
    [filter3 addTarget:filter4];
    
    GPUImageUnsharpMaskFilter *filter5 = [[GPUImageUnsharpMaskFilter alloc] init];
    filter5.intensity = 5;
    filter5.blurRadiusInPixels = 5;
    //  filter5.contrast = 0.8;
    [filter4 addTarget:filter5];
    
    GPUImagePosterizeFilter *filter6 = [[GPUImagePosterizeFilter alloc] init];
    filter6.colorLevels = 25;
    [filter5 addTarget:filter6];
    
    
    
    
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc]init];
    [groupFilter addTarget:filter1];
    [groupFilter addTarget:filter2];
    [groupFilter addTarget:filter3];
    [groupFilter addTarget:filter4];
    [groupFilter addTarget:filter5];
    [groupFilter addTarget:filter6];
    [groupFilter setInitialFilters:[NSArray arrayWithObjects:filter1, nil]];
    [groupFilter setTerminalFilter:filter6];
    
    [groupFilter useNextFrameForImageCapture];
    [stillImageSource addTarget:groupFilter];
    [stillImageSource processImage];
    
    UIImage *currentFilteredImage = [groupFilter imageFromCurrentFramebuffer];
    UIImage *image1 = [UIImage imageWithCGImage:currentFilteredImage.CGImage
                                          scale:currentFilteredImage.scale
                                    orientation:UIImageOrientationRight];
    UIImage *image2 = [UIImage imageWithCGImage:image1.CGImage
                                          scale:image1.scale
                                    orientation:UIImageOrientationDownMirrored];
    UIImage *image3 = [UIImage imageWithCGImage:image2.CGImage
                                          scale:image2.scale
                                    orientation:UIImageOrientationLeftMirrored];
    
    
    
    
    
    filteredImage = image3;
     NSLog(@"Image Size 0 %@", currentFilteredImage);
     NSLog(@"Image Size 1 %@", image1);
     NSLog(@"Image Size 2 %@", image3);
     NSLog(@"Image Size 3 %@", image2);
    [self.collectionView reloadData];
}

- (IBAction)PlusBtnPressed:(id)sender {
    
    CustomizeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomizeVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)menuClicked:(id)sender
{
  [[SideMenuInitialization SharedInstance] ShowMenuIn:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   EmojenicsCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"emo" forIndexPath:indexPath];
    if (_clickedImage != nil) {
        cell.EmoImage.image = filteredImage;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(((self.view.bounds.size.width)/3.4),((self.view.bounds.size.width)/3.4) );
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    PreviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviewVC"];
    vc.ReciveImage= filteredImage;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
