//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "TitleTableViewCell.h"
#import "AppController.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
}
AppController* appcell;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appcell = [AppController getAppInstance];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    menuItems = @[@"title",@"Home" ,@"Process", @"Requisition", @"Sourcing", @"Skill Sourcing",@"Onboarding", @"Attendance", @"Others", @"Reports"];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    TitleTableViewCell *cell;
    if ([CellIdentifier isEqualToString:@"title"])
    {
      cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
      cell.custName.text=[appcell customerName];
      cell.custidCell.text=[appcell username];
      cell.imageProfile.image=[appcell imgesPhoto];
      cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.size.width / 2;
      cell.imageProfile.clipsToBounds = YES;
        
    }
    
    else{
        
       
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell.contentView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [cell.contentView.layer setBorderWidth:.35f];
        
        }
    
    if(indexPath.row>0){
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"img7.jpg"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        
        
        
    }
    else{
        
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if(indexPath.row==9)
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"UserId"];
        [defaults removeObjectForKey:@"custType"];
    }
    
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];

}

-(void)viewDidAppear:(BOOL)animated{
//    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img8.jpg"]];
//   [tempImageView setFrame:self.tableView.frame];
//   
//    self.tableView.backgroundView = tempImageView;
    
    
//    self.tableView.backgroundColor=[UIColor colorWithRed:31/255 green:33/255 blue:36/255 alpha:1];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    else {
        return 50;
    }
}


@end
