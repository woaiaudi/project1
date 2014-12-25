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
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerLabel;
@property (strong, nonatomic) IBOutlet UILabel *linktelLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *zipLabel;
@property (strong, nonatomic) IBOutlet UILabel *webaddLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *callButton;

- (IBAction)callAction:(id)sender;
@end
