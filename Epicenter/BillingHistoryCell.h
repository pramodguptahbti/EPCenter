//
//  BillingHistoryCell.h
//  SEL
//
//  Created by Net Connect PVT.LTD on 08/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillingHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *bill_date;
@property (weak, nonatomic) IBOutlet UILabel *current_bill;
@property (weak, nonatomic) IBOutlet UILabel *amt_payable;
@property (weak, nonatomic) IBOutlet UILabel *invoice_no;
@property (weak, nonatomic) IBOutlet UIButton *downloadBill;
@property (weak, nonatomic) IBOutlet UIView *BillView;

- (IBAction)downloadCurrentBill:(id)sender;
@end
