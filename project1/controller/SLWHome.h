//
//  SLWHome.h
//  project1
//
//  Created by zyue on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeImageButton.h"
#import "AOScrollerView.h"
@interface SLWHome : UIViewController<ValueClickDelegate>
@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) IBOutlet HomeImageButton *leftButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *right1Button;
@property (strong, nonatomic) IBOutlet HomeImageButton *right2Button;
@end
