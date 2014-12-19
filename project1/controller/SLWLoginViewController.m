//
//  SLWLoginViewController.m
//  project1
//
//  Created by zyue on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWLoginViewController.h"
#import "UIHelper.h"
#import "SLWSignUpViewController.h"

@interface SLWLoginViewController ()

@end

@implementation SLWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_usernameTextView setRequired:YES];//必填
    [_passwordtextView setRequired:YES];//必填
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
}

- (IBAction)goSignupPageAction:(id)sender {
    [UIHelper pushViewController:[SLWSignUpViewController class] andTitle:@"注册新用户" byFromViewController:self];
}
@end
