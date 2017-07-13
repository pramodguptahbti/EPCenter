//
//  ViewController.h
//  SEL
//
//  Created by Net Connect PVT.LTD on 04/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, retain) NSDictionary *data;

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;

- (IBAction)logIn:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
- (IBAction)forgotClick:(id)sender;

@end

