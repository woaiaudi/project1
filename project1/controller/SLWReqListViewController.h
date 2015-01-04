//
//  SLWReqListViewController.h
//  project1
//
//  Created by zyue on 15/1/4.
//  Copyright (c) 2015年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLocateView.h"
@interface SLWReqListViewController : UIViewController<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *reqTableview;

@property (strong, nonatomic) IBOutlet UIButton *guigeButton;
@property (strong, nonatomic) IBOutlet UIButton *yongtuButton;
@property (strong, nonatomic) IBOutlet UIButton *diquButton;

- (IBAction)guigeAction:(id)sender;
- (IBAction)yongtuAction:(id)sender;
- (IBAction)diquActiion:(id)sender;


@end
