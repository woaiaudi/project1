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
@property (strong, nonatomic) IBOutlet HomeImageButton *newsButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *supplyButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *requirementButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *companyButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *bbsButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *aboutusButton;


@end
