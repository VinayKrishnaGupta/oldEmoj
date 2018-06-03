//
//  LoginVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 18/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "LoginVC.h"
#import "RegistrationVC.h"
#import "EditInfoVC.h"
#import "SetUpVC.h"

@interface LoginVC ()<UITextFieldDelegate>
{
    NSDictionary * dic;
    NSString * userID;
    UITapGestureRecognizer *singleTap;

}
@property (weak, nonatomic) IBOutlet UIView *EmailView;
@property (weak, nonatomic) IBOutlet UIView *PasswordView;
@property (weak, nonatomic) IBOutlet UITextField *EmailText;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:tap];
    tap.enabled=YES;
    tap.cancelsTouchesInView = NO;
    singleTap=tap;
    
    
    
    self.EmailView.layer.cornerRadius = 25;
     self.EmailView.clipsToBounds = YES;
    
    self.PasswordView.layer.cornerRadius = 25;
     self.PasswordView.clipsToBounds = YES;
    
    
    [self.EmailText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
             forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.PasswordText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.EmailText resignFirstResponder];
    [self.PasswordText resignFirstResponder];
}


- (IBAction)SignUpBtnPressed:(id)sender {
    
    RegistrationVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationVC"];
    
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)SigninBtnPressed:(id)sender {
   
    [self LoginWebService];
}
- (IBAction)SigninFbBtnPressed:(id)sender {
    
    SetUpVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUpVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)LoginWebService
{
    if ([self showAlert])
    {
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
      //  NSString *devToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicetoken"];
        
        [WebServiceBaseClass CallPost:BaseURL@"default_controller/login" Param:@{@"identity":_EmailText.text,@"password":_PasswordText.text} Completion:^(BOOL isSucceed, NSDictionary *response) {
            
            @try {
                //if ([[response valueForKey:@"status"] integerValue] == 1)
                // NSString * str=[response valueForKey:@"status"];
                
                
                
                if ([[response valueForKey:@"status"] isEqualToString:@"success"])
                {
                    
                    dic=[response valueForKey:@"results"];
                    NSLog(@"Dictionary is %@",dic);
                    [[NSUserDefaults standardUserDefaults ] setValue:[dic valueForKey:@"id"] forKey:@"user_id"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"email"] forKey:@"email"];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"username"] forKey:@"Name"];
                    
                    NSLog(@"CustomerID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"id"]);
                    
                    NSLog(@"EmailID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]);
                    
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"Name"];
                    NSLog(@"EmailID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Name"]);
                    
                    
                    SetUpVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetUpVC"];
                    
                    [self.navigationController pushViewController:vc animated:YES];


                }
                else
                {
                    [self ShowNormalAlertTitle:ALERT_TITLE body:@"Incorrect Login"];
                    
                }
                
                
            } @catch (NSException *exception) {
                [self ShowNormalAlertTitle:ALERT_TITLE body:[ExceptionSingleton messageForException:exception]];
                NSLog(@"%@", exception.reason);
            } @finally {
                NSLog(@"finally...");
                [SVProgressHUD dismiss];
            }
            NSLog(@"response = %@",response);
            
            
        }];
        
    }
    
}





-(BOOL)showAlert
{
    if ([[self.EmailText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter your email"];
        return NO;
     }
   else if (![self IsValidEmail:self.EmailText.text])
   {
     [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter a valid email"];
      return NO;
    }
    else if ([[_PasswordText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0)
    {
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter password"];
        return NO;
    }
    return YES;
}




@end
