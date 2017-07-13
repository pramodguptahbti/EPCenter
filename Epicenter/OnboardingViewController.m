//
//  OnboardingViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 13/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "OnboardingViewController.h"
#import "AppController.h"

@interface OnboardingViewController ()

@end

@implementation OnboardingViewController
AppController *onboarding;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Onboarding";
    
    
    onboarding = [AppController getAppInstance];
    [onboarding setNavBar:self :_sideBarButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
