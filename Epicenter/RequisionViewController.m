//
//  RequisionViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 12/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "RequisionViewController.h"
#import "AppController.h"

@interface RequisionViewController ()

@end

@implementation RequisionViewController

AppController *requisition;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"Requisition";
    
    requisition = [AppController getAppInstance];
    [requisition setNavBar:self :_sideBarButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
