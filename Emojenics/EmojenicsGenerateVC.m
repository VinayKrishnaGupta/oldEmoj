//
//  EmojenicsGenerateVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 22/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "EmojenicsGenerateVC.h"
#import "CustomizeVC.h"
#import "PreviewVC.h"

@interface EmojenicsGenerateVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EmojenicsGenerateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(((self.view.bounds.size.width)/3.4),((self.view.bounds.size.height)/4.3) );
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    PreviewVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviewVC"];
    vc.ReciveImage=[UIImage imageNamed:@"photo-compressor"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
