//
//  CustomizeVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 22/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "CustomizeVC.h"
#import "CustomDownCollectionCell.h"
#import "CustomUpCollectionCell.h"
#import "EmojenicsList.h"

@interface CustomizeVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     int selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet UICollectionView *DownCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *UPCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation CustomizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndexPath = -1;
    // Do any additional setup after loading the view.

    
    self.profileImageView.image=self.SendToImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DoneBtnPressed:(id)sender {
    
    EmojenicsList *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmojenicsList"];
    vc.clickedImage = self.SendToImage;

    [self.navigationController pushViewController:vc animated:YES];
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
////    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerController.delegate = self;
//    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
//    {
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            [self presentViewController:imagePickerController animated:YES completion:nil];
//        }];
//    }
//    else{
//        [self presentViewController:imagePickerController animated:YES completion:nil];
//    }
    
  
    
}
- (IBAction)Back:(id)sender {
    
      [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openCamera:(id)sender
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Device has no camera."] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    self.profileImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     if (collectionView == self.DownCollectionView)
     {
          return 12;
         
     }else
     {
          return 12;
     }
   
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.DownCollectionView) {
        CustomDownCollectionCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        return cell;
    }
    else
    {
        CustomUpCollectionCell*cell1=[self.UPCollectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        if (indexPath.row == selectedIndexPath) {
            cell1.BgCellImage.hidden=NO;
            cell1.BgCellImage.image = [UIImage imageNamed:@"customizing-orange1"];
            cell1.BottomMargin.constant=30;
            [self.view layoutIfNeeded];

            
        }else
        {
            cell1.BgCellImage.hidden=YES;
            cell1.BottomMargin.constant=5;
            [self.view layoutIfNeeded];
            
            //cell1.BgCellImage.image = [UIImage imageNamed:@"customizing-orange1"];

        }

        return cell1;
    }
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.DownCollectionView)
    {
      return CGSizeMake(50, 50);
    }
    else
    {
      return CGSizeMake(80 , 110);
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.DownCollectionView)
    {
    }
    else
    {
      CustomUpCollectionCell*cell1=[self.UPCollectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.contentView.backgroundColor = [UIColor clearColor];
    }
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.DownCollectionView)
    {
    }
    else if (collectionView == self.UPCollectionView)
    {
        
        if (selectedIndexPath == (int)indexPath.row) {
            selectedIndexPath = -1;
        }
        else {
            selectedIndexPath = (int)indexPath.row;
        }

        [self.UPCollectionView reloadData];
        
        
        //cell.contentView.backgroundColor = [UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1];
    }
}


@end
