//
//  ListViewController.h
//  Epicenter
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 06/04/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
