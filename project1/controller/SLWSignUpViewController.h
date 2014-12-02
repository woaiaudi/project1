//
//  SLWSignUpViewController.h
//  project1
//
//  Created by 张跃 on 14/12/1.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DLRadioButton.h>
#import "NIDropDown.h"

@interface SLWSignUpViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown * dropDown;
}
@property (strong, nonatomic) IBOutlet UIButton *selectPwdQuestButton;
- (IBAction)clickPwdQuestAction:(id)sender;

@property (strong, nonatomic) IBOutletCollection(DLRadioButton) NSArray *sexRadioButton;

- (IBAction)userSignupCommitAction:(id)sender;
@end
