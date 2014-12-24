//
//  SLWNewsDetailViewController.h
//  project1
//
//  Created by zyue on 14/12/24.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWNewsDetailViewController : UIViewController
@property(nonatomic,copy)NSString *newsId;
@property (strong, nonatomic) IBOutlet UIWebView *newsWebview;
@end
