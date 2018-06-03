//
//  SetUpVC.m
//  Emojenics
//
//  Created by Elagoon 1 on 19/01/18.
//  Copyright © 2018 Elagoon 1. All rights reserved.
//

#import "SetUpVC.h"
#import "SetUpTableViewCell.h"
#import "CameraVC.h"


@interface SetUpVC ()
{
    NSArray *tableData;
}
@property (weak, nonatomic) IBOutlet UITableView *SetTableView;


@end

@implementation SetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      tableData = [NSArray arrayWithObjects:@"1. Open your device Settings", @"2. General", @"3. Keyboard", @"4. Keyboards", @"5.Add New Keyboard", @"6. Emojenics", @"7. Tap emojenics-emojenics", @"8.Allow Full Access", nil];
   
}

- (IBAction)menuClicked:(id)sender
{
    [[SideMenuInitialization SharedInstance] ShowMenuIn:self];
}

- (IBAction)DoneBtnPressed:(id)sender {
    CameraVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraVC"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
  return [tableData count];
    
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath

{
    
    SetUpTableViewCell *cell;
    cell= [self.SetTableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.setupLabel.text=[tableData objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.setUpImage.image=[UIImage imageNamed:@"settings"];

    }
    else if (indexPath.row==1)
    {
        cell.setUpImage.image=[UIImage imageNamed:@"General"];
    }
    else
    {
        cell.setUpImage.image=[UIImage imageNamed:@""];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(235/255.f) green:(126/255.f) blue:(34/255.f) alpha:1];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}

@end
