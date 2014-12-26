//
//  SLWUserDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/26.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWUserDetailViewController.h"

@interface SLWUserDetailViewController ()

@end

@implementation SLWUserDetailViewController
@synthesize userBean;
- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text = userBean.username;
    _realNameLabel.text = userBean.realname;
    _companyLabel.text = userBean.company;
    _typeLabel.text = userBean.usertype;
    _sexLabel.text = userBean.sex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
