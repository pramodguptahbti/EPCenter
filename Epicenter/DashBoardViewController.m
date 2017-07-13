//
//  DashBoardViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 07/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "DashBoardViewController.h"
#import "SWRevealViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"News";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
