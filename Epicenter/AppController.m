//
//  AppController.m
//  SEL
//
//  Created by Net Connect PVT.LTD on 17/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import "AppController.h"
#import "SWRevealViewController.h"

@implementation AppController
static NSString *const SEL_URL = @"http://103.233.79.76/Sitienergy/";
//static NSString *const SEL_URL = @"http://192.168.1.89:8080/Sitienergy/";

+ (id)getAppInstance {
    static AppController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    if (self = [super init]) {
        //someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)setUsername:(NSString *)username{
    _username = username;
    
}

- (void)setPassword:(NSString *)password{
    _password = password;
}

- (void)setCustomerName:(NSString *)customerName{
    _customerName = customerName;
}

- (void)setEmail:(NSString *)email{
    _email = email;
}

- (void)setMobile:(NSString *)mobile{
    _mobile = mobile;
}


- (void)setImgesPhoto:(UIImage *)userpic{
    _imgesPhoto = userpic;
    
    NSLog(@"_imgesPhoto====%@",_imgesPhoto);
    
    
    
}
- (void)setCustType:(NSString *)custType{
    _custType = custType;
}


-(void)setNavBar:(UIViewController *)controller :(UIBarButtonItem *)sideBarButton{
    SWRevealViewController *revealViewController = controller.revealViewController;
    if ( revealViewController )
    {
        [sideBarButton setTarget: controller.revealViewController];
        [sideBarButton setAction: @selector( revealToggle: )];
        [controller.view addGestureRecognizer:controller.revealViewController.panGestureRecognizer];
    }
}

-(NSString *)getDataFromServer:(NSString *)url :(NSString *)post{
    NSString *success;
    NSString *jsonData;
    @try{
//        NSLog(@"PostData: %@",post);
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",SEL_URL,url];
        
        NSURL *url=[NSURL URLWithString:urlString];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            jsonData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
           // NSLog(@"Response ==> %@", jsonData);
            return jsonData;
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [self getToastDisplay:@"Connection Failed!"];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self getToastDisplay:@"Connection Failed!"];
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }

   // jsonData = @{@"RESULT":@"FAIL"};
    
    return jsonData;
}

- (void)getToastDisplay:(NSString*)message{
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil                                                            message:message
                                                   delegate:nil                                                  cancelButtonTitle:nil                                                  otherButtonTitles:nil, nil];
    toast.backgroundColor=[UIColor redColor];
    [toast show];
    int duration = 2;            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{                [toast dismissWithClickedButtonIndex:0 animated:YES];            });
}

@end
