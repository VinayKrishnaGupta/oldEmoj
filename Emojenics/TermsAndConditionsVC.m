//
//  TermsAndConditionsVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 23/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "TermsAndConditionsVC.h"

@interface TermsAndConditionsVC ()

@end

@implementation TermsAndConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuClicked:(id)sender
{
    [[SideMenuInitialization SharedInstance] ShowMenuIn:self];
}


@end
