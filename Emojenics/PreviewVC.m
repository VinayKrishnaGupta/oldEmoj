//
//  PreviewVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 22/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "PreviewVC.h"
#import "CustomizeVC.h"

@interface PreviewVC ()

@property (weak, nonatomic) IBOutlet UIImageView *PriviewImage;

@end

@implementation PreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.PriviewImage.image=self.ReciveImage;
    
}
- (IBAction)RightBtnPressed:(id)sender {
    
    CustomizeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomizeVC"];
    
    vc.SendToImage=self.ReciveImage;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)CrossBtnPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
