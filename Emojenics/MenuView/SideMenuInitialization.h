//
//  SideMenuInitialization.h
//  Nativo
//
//  Created by ELAGOON DIGITAL PVT. LTD. on 16/10/17.
//  Copyright © 2017 Elagoon2. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SideMenuInitialization : NSObject

+(instancetype)SharedInstance;
-(void)ShowMenuIn:(UIViewController *)viewController;
-(void)HideMenu;
-(void)HideMenuWithCompletion:(void(^)(BOOL isDone))completion;
-(void)PushWithStoryboardID:(NSString *)storyboardID From:(UIViewController *)viewController;
+(void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message InViewConroller:(UIViewController *)viewController;
+(void)ShowAlertWithTitle:(NSString *)title Message:(NSString *)message InViewConroller:(UIViewController *)viewController andButtonName:(NSString *)buttonTitle;
@end
