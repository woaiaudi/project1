//
//  SLWSearchViewController.h
//  project1
//
//  Created by zyue on 14/12/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "TSLocateView.h"
@interface SLWSearchViewController : UIViewController<NIDropDownDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIButton *searchTypeButton;

- (IBAction)searchTypeButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *cityButton;
- (IBAction)cityAction:(id)sender;

@end
