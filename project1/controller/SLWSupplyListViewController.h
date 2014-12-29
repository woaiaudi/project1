//
//  SLWSupplyListViewController.h
//  project1
//
//  Created by zyue on 14/12/14.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface SLWSupplyListViewController : UIViewController<NIDropDownDelegate>
@property (strong, nonatomic) IBOutlet UITableView *supplyTableview;

@property (strong, nonatomic) IBOutlet UIButton *yongtuButton;
@property (strong, nonatomic) IBOutlet UIButton *diquButton;
@property (strong, nonatomic) IBOutlet UIButton *guigeButton;

- (IBAction)yongtuAction:(id)sender;
- (IBAction)diquAction:(id)sender;
- (IBAction)guigeAction:(id)sender;

@end
