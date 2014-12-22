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
#import "UserService.h"

@interface SLWLoginViewController ()
{
    UserService *userService;
}

@end

@implementation SLWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userService = [[UserService alloc]init];
    [_usernameTextView setRequired:YES];//必填
    [_passwordtextView setRequired:YES];//必填
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {

    [userService loginByName:_usernameTextView.text pwd:_passwordtextView.text onsuccess:^(UserBean *pBlockBean) {
        //登录成功到首页，更新首页数据
        [UIHelper popToRootViewControllerAnimated:self];
    } onfailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

- (IBAction)goSignupPageAction:(id)sender {
    [UIHelper pushViewController:[SLWSignUpViewController class] andTitle:@"注册新用户" byFromViewController:self];
}
@end
