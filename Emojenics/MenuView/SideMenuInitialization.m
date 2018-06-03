//
//  SideMenuInitialization.m
//  Nativo
//
//  Created by ELAGOON DIGITAL PVT. LTD. on 16/10/17.
//  Copyright © 2017 Elagoon2. All rights reserved.
//

#import "SideMenuInitialization.h"
#import "MenuView.h"

MenuView *menuView;
UIView *menuBackView;

@implementation SideMenuInitialization
{
    NSArray *itemsArr;
    UIViewController *viewController;
}

+(instancetype)SharedInstance {
    
    static SideMenuInitialization *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SideMenuInitialization alloc] init];
    });
    return sharedInstance;
    
}
//-(void)PushWithStoryboardID:(NSString *)storyboardID From:(UIViewController *)viewControllera {
//    [viewControllera.navigationController pushViewController:[viewControllera.storyboard instantiateViewControllerWithIdentifier:storyboardID] animated:YES];
//}
-(void)ShowMenuIn:(UIViewController *)viewControl {
    viewController=viewControl;
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    menuView = [[NSBundle mainBundle] loadNibNamed:@"MenuXib" owner:viewControl options:nil][0];
    menuView.frame = CGRectMake(0, 0, screenSize.size.width/2, screenSize.size.height);
    menuView.leftMenuTable.delegate = menuView;
    menuView.leftMenuTable.dataSource = menuView;
    [menuView setMenuItemsIn:viewControl];
    menuBackView = [[UIView alloc] initWithFrame:screenSize];
    menuBackView.backgroundColor = [UIColor blackColor];
    menuBackView.alpha = 0.0;
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu)];
    oneTap.numberOfTapsRequired = 1;
    [menuBackView addGestureRecognizer:oneTap];
    [viewControl.view addSubview:menuBackView];
    [viewControl.view addSubview:menuView];
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.frame = CGRectMake(0, 0, screenSize.size.width/2+20, screenSize.size.height);
        menuBackView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

-(void)HideMenu {
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.frame = CGRectMake(-screenSize.size.width/2, 0, screenSize.size.width/2, screenSize.size.height);
        menuBackView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [menuView removeFromSuperview];
        [menuBackView removeFromSuperview];
        
        
    }];
}
-(void)HideMenuWithCompletion:(void(^)(BOOL isDone))completion {
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.frame = CGRectMake(-screenSize.size.width/2, 0, screenSize.size.width/2, screenSize.size.height);
        menuBackView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [menuView removeFromSuperview];
        [menuBackView removeFromSuperview];
        completion(YES);
        
    }];
}

-(void)PushWithStoryboardID:(NSString *)storyboardID From:(UIViewController *)viewControllera {
    [viewController.navigationController pushViewController:[viewControllera.storyboard instantiateViewControllerWithIdentifier:storyboardID] animated:YES];
}
+(void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message InViewConroller:(UIViewController *)viewController {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [viewController presentViewController:alertC animated:YES completion:nil];
}
+(void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message InViewConroller:(UIViewController *)viewController andButtonName:(NSString *)buttonTitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil]];
    [viewController presentViewController:alertC animated:YES completion:nil];
}

@end
