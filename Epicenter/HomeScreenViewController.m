//
//  HomeScreenViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 06/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "ViewController.h"
#import "AppController.h"
@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController
AppController* appHome;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackground];
    
    
    appHome = [AppController getAppInstance];
    [appHome setNavBar:self :_sideBarButton];
    
    

}

-(void)setBackground{
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    //[self.view addSubview:backgroundView];
    //[self.view sendSubviewToBack:backgroundView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
