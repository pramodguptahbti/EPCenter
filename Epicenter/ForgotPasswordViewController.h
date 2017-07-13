//
//  ForgotPasswordViewController.h
//  SEL
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 07/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Fusername;

@property (weak, nonatomic) IBOutlet UITextField *FemailMobile;
@property (nonatomic, retain) NSDictionary *data;
@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedControl;


- (IBAction)resetClickBtn:(id)sender;


@end
