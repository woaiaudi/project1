//
//  SLWLoginViewController.h
//  project1
//
//  Created by zyue on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTextField.h"

@interface SLWLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet MHTextField *usernameTextView;
@property (strong, nonatomic) IBOutlet MHTextField *passwordtextView;


- (IBAction)loginAction:(id)sender;
- (IBAction)goSignupPageAction:(id)sender;

@end
