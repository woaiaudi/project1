//
//  SLWSignUpViewController.m
//  project1
//
//  Created by zyue on 14/12/1.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSignUpViewController.h"
#import "UIHelper.h"
#import "UserService.h"
#import <TSMessage.h>
@interface SLWSignUpViewController ()
{
    UserService *userService;
    NSArray * pwdqArray;
}

@end

@implementation SLWSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userService = [[UserService alloc]init];
    
    //不能超过11个汉字
    pwdqArray = [NSArray arrayWithObjects:@"出生城市", @"最喜欢的电影",@"最喜欢的演员", @"最常上的网站", @"最喜欢的车",nil];
    
    [_userNameTextField setRequired:YES];//登录账户 必填
    [_pwd1TextField setRequired:YES];//密码必填
    [_pwd2TextField setRequired:YES];//密码2 判断
   // [_answerTextField setRequired:YES];//问题答案
    //[_realNameTextField setRequired:YES];//真实姓名

    
    //设置性别选择按钮
    for (DLRadioButton *radioButton in self.sexRadioButton) {
        radioButton.ButtonIcon = [UIImage imageNamed:@"RadioButton"];
        radioButton.ButtonIconSelected = [UIImage imageNamed:@"RadioButtonSelected"];
    }
    
    //密码提示问题按钮，圆角处理
    _selectPwdQuestButton.layer.borderWidth = 1;
    _selectPwdQuestButton.layer.borderColor = [[UIColor redColor] CGColor];
    _selectPwdQuestButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 注册按钮 事件
- (IBAction)userSignupCommitAction:(id)sender {
    //验证用户名非空
    if (!_userNameTextField.isValid){
        [TSMessage showNotificationWithTitle:@"注册失败"
                                    subtitle:@"用户名不能为空"
                                        type:TSMessageNotificationTypeError];
        return;
    }
    //验证mima非空
    if (!_pwd1TextField.isValid){
        [TSMessage showNotificationWithTitle:@"注册失败"
                                    subtitle:@"密码不能为空"
                                        type:TSMessageNotificationTypeError];
        return;
    }
    //验证两次密码
    if (![_pwd1TextField.text isEqualToString:_pwd2TextField.text]) {
        [TSMessage showNotificationWithTitle:@"注册失败"
                                    subtitle:@"两次输入的密码不一致"
                                        type:TSMessageNotificationTypeError];
        return;
    }
    NSString *pwdqStr = _selectPwdQuestButton.titleLabel.text;
    NSString *sexStr = [(DLRadioButton *)self.sexRadioButton[0] selectedButton].titleLabel.text;
    [userService registerByUsername:_userNameTextField.text password:_pwd1TextField.text pwdq:pwdqStr pwda:_answerTextField.text realname:_realNameTextField.text sex:sexStr company:_companyTextField.text  usertype:@"geren" onsuccess:^(UserBean *pBlockBean) {
        [TSMessage showNotificationWithTitle:@"恭喜"
                                    subtitle:@"注册成功"
                                        type:TSMessageNotificationTypeSuccess];
        [userService saveAccessedUserBean:pBlockBean];
        [UIHelper popToRootViewControllerAnimated:self];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"注册失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
    
    
}
#pragma mark- 密码提示问题
- (IBAction)clickPwdQuestAction:(id)sender {
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :pwdqArray :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
}
- (void) niDropDownDelegateMethod:(NIDropDown *)sender  byClickedButton:(UIButton *)button selectedIndex:(NSIndexPath *)index
{
    dropDown = nil;
}
@end
