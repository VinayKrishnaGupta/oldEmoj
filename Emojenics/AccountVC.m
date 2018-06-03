//
//  AccountVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 23/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "AccountVC.h"

@interface AccountVC ()
{
    UITapGestureRecognizer *singleTap;
}
@property (weak, nonatomic) IBOutlet UIView *YourNameView;
@property (weak, nonatomic) IBOutlet UIView *YourPhoneView;
@property (weak, nonatomic) IBOutlet UIView *EmailView;
@property (weak, nonatomic) IBOutlet UIView *DobView;
@property (weak, nonatomic) IBOutlet UIView *CpasswordView;
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *PhoneText;
@property (weak, nonatomic) IBOutlet UITextField *EmailText;
@property (weak, nonatomic) IBOutlet UITextField *DobText;
@property (weak, nonatomic) IBOutlet UITextField *RePasswordText;
@end

@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:tap];
    tap.enabled=YES;
    tap.cancelsTouchesInView = NO;
    singleTap=tap;

    
    self.YourNameView.layer.cornerRadius = 23;
    self.YourNameView.clipsToBounds = YES;
    self.YourPhoneView.layer.cornerRadius = 23;
    self.YourPhoneView.clipsToBounds = YES;
    self.EmailView.layer.cornerRadius = 23;
    self.EmailView.clipsToBounds = YES;
    self.DobView.layer.cornerRadius = 23;
    self.DobView.clipsToBounds = YES;
    self.CpasswordView.layer.cornerRadius = 23;
    self.CpasswordView.clipsToBounds = YES;
    
    
//    [self.NameText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
//                 forKeyPath:@"_placeholderLabel.textColor"];
//    [self.PhoneText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
//                  forKeyPath:@"_placeholderLabel.textColor"];
//    [self.EmailText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
//                  forKeyPath:@"_placeholderLabel.textColor"];
//    [self.DobText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
//                     forKeyPath:@"_placeholderLabel.textColor"];
//    [self.RePasswordText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
//                       forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.NameText resignFirstResponder];
    [self.PhoneText resignFirstResponder];
    [self.EmailText resignFirstResponder];
    [self.RePasswordText resignFirstResponder];
}
- (IBAction)menuClicked:(id)sender
{
    [[SideMenuInitialization SharedInstance] ShowMenuIn:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AccountWebService
{
    
    NSString *userid=[[NSUserDefaults standardUserDefaults ] valueForKey:@"user_id"];
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    
    
    [WebServiceBaseClass CallPost:BaseURL@"Account" Param:@{@"id":userid} Completion:^(BOOL isSucceed, NSDictionary *response) {
        
        @try {
            
            if ([[response valueForKey:@"status"] isEqualToString:@"success"])
            {
                /* NSDictionary * dic=[response valueForKey:@"new_user"];
                 _userNameTxt.text=[dic valueForKey:@"username"];
                 _emailTxt.text=[dic valueForKey:@"email"];
                 _dobTxt.text=[dic valueForKey:@"dob"];
                 _Namelbl.text=[dic valueForKey:@"first_name"];
                 _EditEmailTxt.text=[dic valueForKey:@"email"];
                 _EditUsernameTxt.text=[dic valueForKey:@"username"];
                 _EditDobTxt.text=[dic valueForKey:@"dob"];
                 // [[NSUserDefaults standardUserDefaults]setObject:[dic valueForKey:@"username"] forKey:@"username"];
                 // [[NSUserDefaults standardUserDefaults]synchronize];
                 */
                
            }
            else
            {
                [self ShowNormalAlertTitle:ALERT_TITLE body:@"Profile details not found"];
                
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





@end
