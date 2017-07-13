//
//  SkillSourcingViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 13/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "SkillSourcingViewController.h"
#import "AppController.h"

@interface SkillSourcingViewController ()

@end

@implementation SkillSourcingViewController
AppController *skillSourcing;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     self.title=@"Skill Sourcing";
    
    skillSourcing = [AppController getAppInstance];
    [skillSourcing setNavBar:self :_sideBarButton];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
