//
//  SLWBBSDetailViewController.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWBBSDetailViewController : UIViewController
@property(nonatomic,copy)NSString *bbsId;
@property (strong, nonatomic) IBOutlet UIWebView *bbsWebview;
@property (strong, nonatomic) IBOutlet UITableView *commentTableview;
@end
