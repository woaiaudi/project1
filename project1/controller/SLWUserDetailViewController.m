//
//  SLWUserDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/26.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWUserDetailViewController.h"
#import "UserService.h"
#import <TSMessage.h>

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
    
    
    UIBarButtonItem *logoutBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"logout.png"] style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction)];
    
    self.navigationItem.rightBarButtonItem = logoutBarButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)logoutAction
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"确认注销当前用户？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UserService *us =  [[UserService alloc]init];
        [us deleteAccessedUserBean];
        [TSMessage showNotificationWithTitle:@"用户退出成功" type:TSMessageNotificationTypeSuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
