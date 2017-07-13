//
//  ProcessViewController.m
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 12/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ProcessViewController.h"
#import "YSLContainerViewController.h"
#import "AppController.h"
#import "ViewProcessViewController.h"

#import "CreateProcessViewController.h"


@interface ProcessViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation ProcessViewController

AppController *appProcess;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    appProcess = [AppController getAppInstance];
    
    [appProcess setNavBar:self :_sideBarButton];
    
    
    
//    @[@"Process", @"Create Process",@"View Process"],
//    @[@"Requisition", @"Create Requisition", @"View Requisition"],
//    @[@"Sourcing",@"Soft Skill Sourcing",@"View Soft Skill Sourcing",@"Technical Skill Sourcing",@"View Technical Skill Sourcing"]
//    ],
//    @[
//      @[@"Onboarding",@"Onboarding Form",@"View Onboarding"],
//      @[@"Attendance",@"Mark Attendance",@"Manager Approval",@"RM Approval"],
//      @[@"Others", @"Add Attrition/Termination", @"Certification", @"Credential Change", @"Upload BGV/NDA", @"View Uploaded BGV/NDA"],
//      @[@"Reports",@"RMR/HR Report",@"Attrition Report",@"Incentive Report",@"Requisition Report",@"Onboarding Report",@"Hiring Report",@"People Plan",@"Genrate RMR Report",@"HC Summary Report",@"HC Forcast Report"]
//    
    
    // NavigationBar
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.font = [UIFont fontWithName:@"Futura-Medium" size:19];
    titleView.textColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
    titleView.text = @"Process";
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    // SetUp ViewControllers
    
    CreateProcessViewController *createVC = [[CreateProcessViewController alloc]initWithNibName:@"CreateProcessViewController" bundle:nil];
    createVC.title = @"Create Process";
    
    
    ViewProcessViewController *playListVC = [[ViewProcessViewController alloc]initWithNibName:@"ViewProcessViewController" bundle:nil];
    playListVC.title = @"View Process                      ";
    
   
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[createVC,playListVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
