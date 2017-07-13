//
//  ReportsViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 13/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ReportsViewController.h"
#import "AppController.h"

@interface ReportsViewController ()

@end

@implementation ReportsViewController
AppController *reports;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title=@"Reports";
    
    reports = [AppController getAppInstance];
    [reports setNavBar:self :_sideBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
