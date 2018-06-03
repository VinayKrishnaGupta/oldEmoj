//
//  EditInfoVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 18/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "EditInfoVC.h"
#import "SetUpVC.h"
#import "AccountVC.h"

@interface EditInfoVC ()

@end

@implementation EditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)OkBtnPressed:(id)sender {
    
    AccountVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)EditInformationBtnPressed:(id)sender {
    
    AccountVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)CancelBtnPressed:(id)sender {
    
    // [self ShowNormalAlertTitle:ALERT_TITLE body:@"Incorrect Login"];
    
    SetUpVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUpVC"];
    
    [self.navigationController pushViewController:vc animated:YES];

}


@end
