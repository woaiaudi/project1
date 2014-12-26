//
//  SLWUserDetailViewController.h
//  project1
//
//  Created by zyue on 14/12/26.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBean.h"
@interface SLWUserDetailViewController : UIViewController
@property(nonatomic,retain) UserBean * userBean;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *realNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;

@end
