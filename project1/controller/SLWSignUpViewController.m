//
//  SLWSignUpViewController.m
//  project1
//
//  Created by zyue on 14/12/1.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSignUpViewController.h"

@interface SLWSignUpViewController ()

@end

@implementation SLWSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户注册";
    
    
    [_userNameTextField setRequired:YES];//登录账户 必填
    [_pwd1TextField setRequired:YES];//密码必填
    [_pwd1TextField setRequired:YES];//密码2 判断
    [_answerTextField setRequired:YES];//问题答案
    [_realNameTextField setRequired:YES];//真实姓名

    
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

#pragma mark - Helpers

- (void)showSelectedButton:(NSArray *)radioButtons {
    NSString *buttonName = [(DLRadioButton *)radioButtons[0] selectedButton].titleLabel.text;
    [[[UIAlertView alloc] initWithTitle: buttonName ? @"Selected Button" : @"No Button Selected" message:buttonName delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
#pragma mark- 注册按钮 事件
- (IBAction)userSignupCommitAction:(id)sender {
    [self showSelectedButton:self.sexRadioButton];
}
#pragma mark- 密码提示问题
- (IBAction)clickPwdQuestAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    //不能超过11个汉字
    arr = [NSArray arrayWithObjects:@"好问问很长很长很长很长", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
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
    NSLog(@"选中了S[%d],R[%d]",index.section,index.row);
}
@end
