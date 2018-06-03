//
//  BaseViewController.h
//  ClickPak
//
//  Created by Elagoon 1 on 25/10/17.
//  Copyright © 2017 Elagoon 1. All rights reserved.
//

#define ALERT_TITLE @"Emojenics"

#import <UIKit/UIKit.h>
#import "SideMenuInitialization.h"
#import "SVProgressHUD.h"
#import "WebServiceConstant.h"
#import "WebServiceBaseClass.h"
#import "ExceptionSingleton.h"



@interface BaseViewController : UIViewController

-(void)ShowNormalAlertTitle:(NSString*)title body:(NSString*)msg;

-(BOOL)IsValidEmail:(NSString *)checkString;
-(BOOL)isNumeric:(NSString *)strr;

@end
