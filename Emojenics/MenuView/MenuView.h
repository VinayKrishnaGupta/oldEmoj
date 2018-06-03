//
//  MenuView.h
//  EZShuttle
//
//  Created by Elagoon 1 on 17/03/17.
//  Copyright © 2017 Elagoon 1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface MenuView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView *leftMenuTable;
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

-(void)setMenuItemsIn:(UIViewController *)currentViewC;

@end
