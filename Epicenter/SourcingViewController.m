//
//  SourcingViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 13/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "SourcingViewController.h"
#import "AppController.h"

@interface SourcingViewController ()

@end

@implementation SourcingViewController

AppController *Sourcing;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Sourcing";
    
    
    Sourcing = [AppController getAppInstance];
    [Sourcing setNavBar:self :_sideBarButton];
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
