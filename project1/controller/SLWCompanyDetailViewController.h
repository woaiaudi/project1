//
//  SLWCompanyDetailViewController.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyService.h"

@interface SLWCompanyDetailViewController : UIViewController

@property(nonatomic,retain) CompanyBean * companyBean;

@property (strong, nonatomic) IBOutlet UIWebView *companyWebview;

@end
