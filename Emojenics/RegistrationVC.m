//
//  RegistrationVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 18/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "RegistrationVC.h"
#import "EditInfoVC.h"
#import "LoginVC.h"


@interface RegistrationVC ()
{
     UITapGestureRecognizer *singleTap;
}
@property (weak, nonatomic) IBOutlet UIView *YourNameView;
@property (weak, nonatomic) IBOutlet UIView *YourPhoneView;
@property (weak, nonatomic) IBOutlet UIView *EmailView;
@property (weak, nonatomic) IBOutlet UIView *PasswordView;
@property (weak, nonatomic) IBOutlet UIView *CpasswordView;
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *PhoneText;
@property (weak, nonatomic) IBOutlet UITextField *EmailText;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;
@property (weak, nonatomic) IBOutlet UITextField *RePasswordText;

@end

@implementation RegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:tap];
    tap.enabled=YES;
    tap.cancelsTouchesInView = NO;
    singleTap=tap;

    
    
    //Phone Pad:--
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _PhoneText.inputAccessoryView = numberToolbar;
 ///
    
    self.YourNameView.layer.cornerRadius = 23;
    self.YourNameView.clipsToBounds = YES;
    self.YourPhoneView.layer.cornerRadius = 23;
    self.YourPhoneView.clipsToBounds = YES;
    self.EmailView.layer.cornerRadius = 23;
    self.EmailView.clipsToBounds = YES;
    self.PasswordView.layer.cornerRadius = 23;
    self.PasswordView.clipsToBounds = YES;
    self.CpasswordView.layer.cornerRadius = 23;
    self.CpasswordView.clipsToBounds = YES;
    
    
    [self.NameText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.PhoneText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.EmailText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.PasswordText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.RePasswordText setValue:[UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.NameText resignFirstResponder];
    [self.PhoneText resignFirstResponder];
    [self.EmailText resignFirstResponder];
    [self.PasswordText resignFirstResponder];
    [self.RePasswordText resignFirstResponder];
}

-(void)cancelNumberPad{
    [_PhoneText resignFirstResponder];
    _PhoneText.text = @"";
}
-(void)doneWithNumberPad{
   // NSString *numberFromTheKeyboard = _PhoneText.text;
    [_PhoneText resignFirstResponder];
}


- (IBAction)RegisterBtnPressed:(id)sender {
    
   
    [self RegistrationWebService];
}

- (IBAction)LoginBtnPressed:(id)sender {
    
    LoginVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RegistrationWebService
{
    if ([self showAlert])
    {
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
        
      //  NSString *devToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicetoken"];
        
        [WebServiceBaseClass CallPost:BaseURL@"default_controller/register" Param:@{@"phone":_PhoneText.text,@"password":_PasswordText.text,@"email":_EmailText.text,@"dob":@"",@"active":@"1",@"full_name":_NameText.text,} Completion:^(BOOL isSucceed, NSDictionary *response) {
            
            @try {
                
                if ([[response valueForKey:@"status"] isEqualToString:@"success"])
                {
                    
                   /* dic=[response valueForKey:@"user_details"];
                    [[NSUserDefaults standardUserDefaults ] setValue:[dic valueForKey:@"user_id"] forKey:@"user_id"];
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"email"] forKey:@"email"];
                    
                    NSLog(@"CustomerID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]);
                    
                    NSLog(@"EmailID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]);
                    //first_name
                    
                    [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"Name"];
                    NSLog(@"EmailID:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Name"]);
                    */
                    
                    EditInfoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditInfoVC"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [self ShowNormalAlertTitle:ALERT_TITLE body:@"registration not successful please try again"];
                    
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
   if ([self.NameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0){
        
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter Name"];
        
        return NO;
    }
    else if ([[self.NameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter Name"];
        return NO;
    }
    else if([self isNumeric:_PhoneText.text]==NO)
    {
        [self ShowNormalAlertTitle:@"Error" body:@"Please enter Valid Mobile Number"];
        return NO;
        
    }
    
    else if(_PhoneText.text.length < 10 )
    {
        [self ShowNormalAlertTitle:@"Error" body:@"Please enter Valid Mobile Number"];
        return NO;
        
    }
    
    else if ([[self.EmailText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter your email"];
        return NO;
    }
    else if (![self IsValidEmail:self.EmailText.text]){
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter a valid email"];
        return NO;
    }
    
    
    else if (!([self.PasswordText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>=6)){
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"Please enter atleast a 6 digit Password"];
        return NO;
    }
    else if (_PasswordText.text!=self.RePasswordText.text){
        [self ShowNormalAlertTitle:ALERT_TITLE body:@"password and confirm password do not match"];
        return NO;
    }
    return YES;
}


@end
