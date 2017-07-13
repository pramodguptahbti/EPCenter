//
//  BillingHistoryViewController.m
//  SEL
//
//  Created by Net Connect PVT.LTD on 08/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import "BillingHistoryViewController.h"
#import "BillingHistoryCell.h"
#import "AppController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
@interface BillingHistoryViewController ()

@end



@implementation BillingHistoryViewController
NSMutableArray *billList;
int cnt=0;
NSMutableDictionary *billId;
AppController* appBill;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appBill = [AppController getAppInstance];
    [appBill setNavBar:self :_sideBarButton];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getBillingList)
                  forControlEvents:UIControlEventValueChanged];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self getBillingList];
       // [MBProgressHUD hideHUDForView:self.view animated:YES];
    });

    
}

-(void) getBillingList{
    
    UILabel *tempLabel = (UILabel *)[self.view viewWithTag:100];
    if(tempLabel)
        [tempLabel removeFromSuperview];
    
        NSDictionary *params = @{@"customer_arn_no": [appBill username]};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://103.233.79.76/SEL/app_billing_history?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            _row = responseObject ;
            
            
            NSLog(@"_data===%@",_row);
            
            billList = [[NSMutableArray alloc] init];
            for (int i=0; i<[_row count]; i++) {
                NSMutableDictionary *dict=[_row objectAtIndex:i];
                NSString * ID=[dict valueForKey:@"id"];
                NSString * invoiceAmount=[dict valueForKey:@"invoice_amount"];
                NSString * totalAmt=[dict valueForKey:@"total_amount"];
                NSString * invoiceDate=[dict valueForKey:@"invoice_date"];
                NSString * invoice=[dict valueForKey:@"invoice"];
                
                NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
                [mDict setValue:ID forKey:@"id"];
                [mDict setValue:invoiceAmount forKey:@"invoice_amount"];
                [mDict setValue:totalAmt forKey:@"total_amount"];
                [mDict setValue:invoiceDate forKey:@"invoice_date"];
                [mDict setValue:invoice forKey:@"invoice"];
                
                [billList addObject:mDict];
            }
            
            if([billList count]){
                cnt++;
                if(cnt>0){
                    [self reloadData];
                }
                [self.refreshControl endRefreshing];
            }
            else {
                [self showLabel];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
}

-(void)showLabel{
    // Display a message when the table is empty
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    messageLabel.tag = 100;
    messageLabel.text = @"No data is currently available. Please pull down to refresh.";
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    //messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [self boldFontForLabel:messageLabel];
    [messageLabel sizeToFit];
    [messageLabel setCenter:self.view.center];
    [self.view addSubview:messageLabel];
    
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *billTableIdentifier = @"BillingHistoryCell";
    tableView.allowsSelection = NO;
    BillingHistoryCell *cell = (BillingHistoryCell *)[tableView dequeueReusableCellWithIdentifier:billTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BillingHistoryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *dateStr = [[billList objectAtIndex:indexPath.row] objectForKey:@"invoice_date"];
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    dateStr = [dateFormat stringFromDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    cell.day.text = [NSString stringWithFormat:@"%li", (long)[components day]];
    cell.month.text = [formatter stringFromDate:date];
    cell.bill_date.text = dateStr;
    
    
    
    cell.current_bill.text = [NSString stringWithFormat:@"%@%@", @"Current Bill period charge: ₹ ",[[billList objectAtIndex:indexPath.row] objectForKey:@"invoice_amount"]];
    cell.amt_payable.text = [NSString stringWithFormat:@"%@%@", @"Amount Payable: ₹ ",[[billList objectAtIndex:indexPath.row] objectForKey:@"total_amount"]];
    cell.invoice_no.text = [NSString stringWithFormat:@"%@%@", @"Invoice No.:  ",[[billList objectAtIndex:indexPath.row] objectForKey:@"invoice"]];
    
    NSString *billIdString = [[billList objectAtIndex:indexPath.row] objectForKey:@"id"];
    cell.downloadBill.tag=indexPath.row;
    [billId setValue:billIdString forKey:[[NSString alloc] initWithFormat:@"%ld", cell.downloadBill.tag]];
    [cell.downloadBill addTarget:self action:@selector(downloadCurrentBill:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.BillView.layer.cornerRadius=5;
    cell.BillView.layer.masksToBounds=YES;
    
    
    return cell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([billList count]) {
        return 1;
        
    }
    return 0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [billList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img8.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
}

-(void)boldFontForLabel:(UILabel *)label{
    UIFont *currentFont = label.font;
    UIFont *newFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",currentFont.fontName] size:currentFont.pointSize];
    label.font = newFont;
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

- (IBAction)downloadCurrentBill:(id)sender {
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Download Bill"
                                  message:@"Are you sure ?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                            
                             NSString *idString = billId[[[NSString alloc] initWithFormat:@"%ld",(long)[sender tag]]];
                             // Get the PDF Data from the url in a NSData Object
                             NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[
                                                                                      NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://103.233.79.76/SEL/billing_data?id=", idString]]];
                             
                             // Store the Data locally as PDF File
                             NSString *resourceDocPath = [[NSString alloc] initWithString:[
                                                                                           [[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]
                                                                                           stringByAppendingPathComponent:@"Documents"
                                                                                           ]];
                             
                            NSString *filePath = [resourceDocPath
                                                   stringByAppendingPathComponent:@"SEL_bill.pdf"];
                             [pdfData writeToFile:filePath atomically:YES];
                             
                             [self setupLocalNotifications];
                             
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
   
}

    - (void)setupLocalNotifications {
       // [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];

        NSDate *date = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hhmmss"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        
        localNotification.fireDate = dateString;
        localNotification.alertBody = @"Time to get up!";
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.applicationIconBadgeNumber = 1; // increment
        
        
        NSString *userInfo =[NSString stringWithFormat:@"%@@SEL_%@.pdf",[appBill username],dateString];
        
        
        NSLog(@"userInfo===%@",userInfo);
        
        NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Object 1",userInfo, @"Object 2", @"Download Completed", nil];
        localNotification.userInfo = infoDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
    

//    // Now create Request for the file that was saved in your documents folder
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    
////    [webView setUserInteractionEnabled:YES];
////    [webView setDelegate:self];
////    [webView loadRequest:requestObj];


@end

