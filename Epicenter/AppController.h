//
//  AppController.h
//  SEL
//
//  Created by Net Connect PVT.LTD on 17/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWRevealViewController.h"

@interface AppController : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *customerName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) UIImage *imgesPhoto;

@property (nonatomic, retain) NSString *custType;


+ (id)getAppInstance;
-(void)setNavBar:(UIViewController *)controller :(UIBarButtonItem *)sideBarButton;
- (NSString *)getDataFromServer:(NSString *)url :(NSString *)post;
- (void)getToastDisplay:(NSString *)message;

@end
