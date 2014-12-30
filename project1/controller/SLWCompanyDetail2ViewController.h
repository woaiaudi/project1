//
//  SLWCompanyDetail2ViewController.h
//  project1
//
//  Created by zyue on 14/12/30.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyService.h"

@interface SLWCompanyDetail2ViewController : UIViewController
@property(nonatomic,retain) CompanyBean * companyBean;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIImageView *companyImageview;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *zipLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyURLLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyAddressLabel;

@property (strong, nonatomic) IBOutlet UIWebView *detailWebview;

@property (strong, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)callAction:(id)sender;


- (IBAction)companyURLAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *vipMarkImageview;
@end
