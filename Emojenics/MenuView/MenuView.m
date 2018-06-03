//
//  MenuView.m
//  EZShuttle
//
//  Created by Elagoon 1 on 17/03/17.
//  Copyright © 2017 Elagoon 1. All rights reserved.
//

#import "MenuView.h"
#import "SideMenuInitialization.h"

@implementation MenuView


{
    NSArray *itemsArr;
    NSArray *imageArr;
    UIViewController *viewController;
   
}

-(void)setMenuItemsIn:(UIViewController *)currentViewC {
    
    viewController = currentViewC;
     itemsArr = [[NSArray alloc] initWithObjects:@"Saved emojis",@"Account",@"Enable Keyboard",@"Settings",@"Build emojis",@"Terms of Use",@"About",@"Logout", nil];
    
     imageArr = [[NSArray alloc] initWithObjects:@"save",@"account",@"keybord",@"Settings1",@"BuildEmojis",@"terms",@"about",@"logout", nil];
    
    self.leftMenuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.leftMenuTable reloadData];
  
}



#pragma mark UITableView Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [self.leftMenuTable dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UILabel *lab = (UILabel*)[cell.contentView viewWithTag:22];
    [lab removeFromSuperview];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
    imageView.image=[UIImage imageNamed:imageArr[indexPath.row]];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 120, 30)];
    label.font = [UIFont systemFontOfSize:14.0];
    NSString *strMenu;

     strMenu= [NSString stringWithFormat:@"   %@",itemsArr[indexPath.row]];
  
    label.text = strMenu;
    
    label.textColor=[UIColor colorWithRed:(59/255.f) green:(126/255.f) blue:(181/255.f) alpha:1];
    label.tag=22;
    [_leftMenuTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [_leftMenuTable
     setSeparatorColor:[UIColor colorWithRed:(235/255.f) green:(247/255.f) blue:(255/255.f) alpha:1]];
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[SideMenuInitialization  SharedInstance] HideMenuWithCompletion:^(BOOL isDone) {
        
       if(indexPath.row == 7)
        {
         NSString *userid=[[NSUserDefaults standardUserDefaults ] valueForKey:@"user_id"];
        if(!([[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] == nil))
            {
               if([userid isEqualToString:@""])
               {
                    [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"LoginVC" From:viewController];
                }
                else
                {
                     [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"SetUpVC" From:viewController];
                }
            }
           
            else
            {
              [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"LoginVC" From:viewController];
            }
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        switch (indexPath.row)
        {
                
            case 0:
                
                [SVProgressHUD showWithStatus:@"Saved Emojis..." maskType:SVProgressHUDMaskTypeBlack];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // time-consuming task
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                });
                
                //[[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"profile" From:viewController];
                break;
            case 1:
                [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"AccountVC" From:viewController];
                break;
                
            case 2:
                 [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"KeyboardVC" From:viewController];
                break;
                
            case 3:
                [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"SetUpVC" From:viewController];
                break;
                
            case 4:
                [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"CameraVC" From:viewController];
                  break;
            case 5:
                 [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"TermsAndConditionsVC" From:viewController];
                break;
                
            case 6:
                 [[SideMenuInitialization SharedInstance]PushWithStoryboardID:@"AboutVC" From:viewController];
                break;
    
                default:
                
                break;
                
        }
        
        
    }];
    
}

-(void)RemeveViewControllersFromNavigation {
    
    NSMutableArray *allViewC = [[NSMutableArray alloc] initWithArray:viewController.navigationController.viewControllers];
    [allViewC removeObjectAtIndex:allViewC.count - 2];
    viewController.navigationController.viewControllers = allViewC;
    
}
@end
