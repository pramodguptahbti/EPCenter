//
//  ViewProcessViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 12/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ViewProcessViewController.h"
#import "DetailViewController.h"
#import "ViewProcessCell.h"

@interface ViewProcessViewController ()
@property (nonatomic, strong) NSMutableArray *playListArray;
@end

@implementation ViewProcessViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"PlayListTableViewController viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ViewProcessCell" bundle:nil] forCellReuseIdentifier:@"ViewProcessCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ViewProcessCell";
    ViewProcessCell *cell = (ViewProcessCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.processNo.text = @"Differnt types of process in";
    cell.srNo.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    cell.srNo.layer.cornerRadius = cell.srNo.frame.size.height/2;
    cell.srNo.layer.masksToBounds = YES;
    cell.srNo.layer.borderColor = [UIColor blackColor].CGColor;
    cell.srNo.layer.borderWidth = 1.0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
