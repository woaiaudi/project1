//
//  SLWHome.h
//  project1
//
//  Created by zyue on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "HomeImageButton.h"
@interface SLWHome : UIViewController<ImagePlayerViewDelegate>
@property (strong, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;

@property (strong, nonatomic) IBOutlet HomeImageButton *leftButton;
@property (strong, nonatomic) IBOutlet HomeImageButton *right1Button;
@property (strong, nonatomic) IBOutlet HomeImageButton *right2Button;
@end
