//
//  ViewController.m
//  SEL
//
//  Created by Net Connect PVT.LTD on 04/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AppController.h"
//#import "HomeViewController.h"
#import "MBProgressHUD.h"

#import "ForgotPasswordViewController.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface ViewController (){
    NSString *selectedIndexNo;
    
}

@end

@implementation ViewController
@synthesize username,password;
AppController* appLogin;


- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self setBackground];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    appLogin = [AppController getAppInstance];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(void)setBackground{
    
    
    
UIImageView *backgroundView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sel_app_logo"]];
   
    [_logoImage sendSubviewToBack:backgroundView1];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)logIn:(id)sender {
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:nil];
    
    
    NSString *success;
    @try {
        
        NSString *user= [username text];
        NSString *pass= [password text];
        
        
        if([user isEqualToString:@""] || [pass isEqualToString:@""] )
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
            
        } else
            {
            
                
//                if (_segmentedControl.selectedSegmentIndex == 0)
//               {
//                  
//                    selectedIndexNo=@"1";
//               }
//                else{
//                   selectedIndexNo=@"2";
//                
//                }
//                
                   NSLog(@"selectedIndexNo==%@",selectedIndexNo);
                   
                   
                   NSString *post =[[NSString alloc] initWithFormat:@"type=ios&userID=%@&password=%@&login=%@",user,pass,selectedIndexNo];
                   NSString *response = [appLogin getDataFromServer:@"login":post];
                   NSData *urlData =[response dataUsingEncoding:NSUTF8StringEncoding];
                   
                   NSError *error = nil;
                   _data = [NSJSONSerialization
                            JSONObjectWithData:urlData
                            options:NSJSONReadingMutableContainers
                            error:&error];
                   
                   success = [_data objectForKey:@"RESULT"];
                   
                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                   if([success  isEqual: @"SUCCESS"])
                   {
                       NSLog(@"Login SUCCESS");
                       appLogin = [AppController getAppInstance];
                       [appLogin setUsername:user];
                       [appLogin setPassword:pass];
                       [appLogin setCustType:selectedIndexNo];
                       
                       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                       [defaults setObject:user forKey:@"UserId"];
                        [defaults setObject:selectedIndexNo forKey:@"custType"];
                       
                       [[NSUserDefaults standardUserDefaults] synchronize];
                       
                       if ([selectedIndexNo isEqualToString:@"1"]) {
                            [self performSegueWithIdentifier:@"login_success" sender:self];
                           
                       }
                       
                       else{
                           
                           
                                            
//                    UploadIndustrialImageViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UploadIndustrialImageViewController"];
//                        [self.navigationController pushViewController:vc animated:YES];
                       }
                       
                       
                       
                   } else {
                       [self alertStatus:@"Username and/or password is invalid" :@"Sign in Failed!" :0];
                       
                         }

                }

            }

    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == username) {
        [textField resignFirstResponder];
        [password becomeFirstResponder];
    } else if (textField == password) {
        
       
        [textField resignFirstResponder];
         textField.secureTextEntry=YES;
        textField.returnKeyType = UIReturnKeyDone;
        
    }
    return YES;
}



- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:username.text])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
    
    if ([sender isEqual:password.text]){
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }

    }
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



- (IBAction)forgotClick:(id)sender {
    
//    ForgotPasswordViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
   // [self presentViewController:vc animated:YES completion:nil];
    
    
    
}
@end

