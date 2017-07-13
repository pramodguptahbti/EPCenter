//
//  ListViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 06/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ListViewController.h"
#import "PieChartViewController.h"
#import "PieChartViewController2.h"
#import "LineChartViewController.h"
#import "AppController.h"

@interface ListViewController ()

@end

@implementation ListViewController
AppController* appList;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    appList = [AppController getAppInstance];
    [appList setNavBar:self :_sideBarButton];
    
    self.title=@"EPCENTER";
    
    _listView.delegate=self;
    _listView.dataSource=self;
   
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.row==0)
    {
        [cell.textLabel setText:@"Total Employees as on Date:2727"];
    }
    else if (indexPath.row==1)
    {
        [cell.textLabel setText:@"Monthly Head Count Requisition(Closed)"];
    }
    else if (indexPath.row==2)
    {
        [cell.textLabel setText:@"Monthly Head Count Requisition(Open)"];
    }
    else if (indexPath.row==3)
    {
       // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"Monthly Head Count Onboarding"];
    }
    else if (indexPath.row==4)
    {
        // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"Month On Month Attrition(FY'17) Attrition/Termination YTD-1"];
    }

    else if (indexPath.row==5)
    {
        // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"Month On Month Skill Upgrade(FY'17)"];
    }

    else if (indexPath.row==6)
    {
        // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"Skill Repository(FY'17)"];
    }

    else if (indexPath.row==7)
    {
        // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"Month On Month Skill Certification(FY'17)"];
    }

    else if (indexPath.row==8)
    {
        // [cell.textLabel setText:@"Line Chart"];
        [cell.textLabel setText:@"free space"];
    }

    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0)
    {
        
        
        
        
        PieChartViewController *detailViewController = [[PieChartViewController alloc] init];
         detailViewController.textName=@"Total Employees as on Date:2727";
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if (indexPath.row==1)
    {
        PieChartViewController2 *detailViewController = [[PieChartViewController2 alloc] init];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if (indexPath.row==2)
    {
       
    }
    else if (indexPath.row==3)
    {
        LineChartViewController *detailViewController = [[LineChartViewController alloc] init];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
