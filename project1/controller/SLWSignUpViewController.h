//
//  SLWSignUpViewController.h
//  project1
//
//  Created by zyue on 14/12/1.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DLRadioButton.h>
#import "ValidateTextField.h"
#import "NIDropDown.h"

@interface SLWSignUpViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown * dropDown;
}
@property (strong, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *pwd1TextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *pwd2TextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *answerTextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *realNameTextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *introductionTextField;
@property (strong, nonatomic) IBOutlet ValidateTextField *companyTextField;




@property (strong, nonatomic) IBOutlet UIButton *selectPwdQuestButton;
- (IBAction)clickPwdQuestAction:(id)sender;

@property (strong, nonatomic) IBOutletCollection(DLRadioButton) NSArray *sexRadioButton;

- (IBAction)userSignupCommitAction:(id)sender;
@end
