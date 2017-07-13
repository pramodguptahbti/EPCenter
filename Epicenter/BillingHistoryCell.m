//
//  BillingHistoryCell.m
//  SEL
//
//  Created by Net Connect PVT.LTD on 08/11/16.
//  Copyright © 2016 NetConnect. All rights reserved.
//

#import "BillingHistoryCell.h"

@implementation BillingHistoryCell
@synthesize day,month,bill_date,current_bill,amt_payable,invoice_no,downloadBill;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)downloadCurrentBill:(id)sender {
}
@end
