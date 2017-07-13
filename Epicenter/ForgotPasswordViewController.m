//
//  ForgotPasswordViewController.m
//  SEL
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 07/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "MBProgressHUD.h"
#import "AppController.h"
#import "ViewController.h"
#import "AFNetworking.h"


#define kOFFSET_FOR_KEYBOARD 80.0
@interface ForgotPasswordViewController (){
    
    
     NSString *selectedIndexNumber;
    
}

@end

@implementation ForgotPasswordViewController
@synthesize Fusername,FemailMobile;
AppController* FpasswordReset;
- (void)viewDidLoad {
    
    [self setBackground];
    [super viewDidLoad];
   
}



- (IBAction)resetClickBtn:(id)sender
{
    
  [MBProgressHUD showHUDAddedTo:self.view animated:nil];
    
    
    @try {
        
        
        NSString *oldpass= [Fusername text];
        NSString *details= [FemailMobile text];
        
            if([oldpass isEqualToString:@""] || [details isEqualToString:@""] )
                {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
        
                } else
                {
        
        
                    if (_segmentedControl.selectedSegmentIndex == 0)
                    {
        
                        selectedIndexNumber=@"1";
                    }
                    else{
                        selectedIndexNumber=@"2";
                        
                    }
                    
                    NSLog(@"selectedIndexNo==%@",selectedIndexNumber);

        NSDictionary *params = @{@"detail":details,
                                 @"cust_id":oldpass,
                                 @"cust_type":@"1"
                                 
                                 };

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://103.233.79.76/SELAndroid/forget_password?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            _data = responseObject ;
            NSLog(@"_data===%@",_data);
            
            
               NSString  *success = [_data objectForKey:@"RESULT"];
            
             [MBProgressHUD hideHUDForView:self.view animated:YES];
              if([success  isEqual: @"SUCCESS"])
                {
                [self alertStatus:@"Your Password Is Sended On Mail" :@"SUCCESS!" :0];

                [self.navigationController popViewControllerAnimated:YES];
            
                     }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
                }
    }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    
    
    [MBProgressHUD hideHUDForView:self.view animated:nil];
    
    
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
    if (textField == Fusername) {
        [textField resignFirstResponder];
        [FemailMobile becomeFirstResponder];
    } else if (textField == FemailMobile) {
        
        
        [textField resignFirstResponder];
       
        textField.returnKeyType = UIReturnKeyDone;
        
    }
    return YES;
}



- (IBAction)backgroundTap:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
    if ([sender isEqual:Fusername.text])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
    
    if ([sender isEqual:FemailMobile.text]){
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



-(void)setBackground{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img7.jpg"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
