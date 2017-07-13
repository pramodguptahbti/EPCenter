//
//  SideTableViewController.h
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 07/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"

@interface SideTableViewController : UIViewController<SKSTableViewDelegate>
@property (nonatomic, weak) IBOutlet SKSTableView *tableView;
@end
