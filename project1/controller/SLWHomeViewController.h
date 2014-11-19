//
//  SLWHomeViewController.h
//  project1
//
//  Created by 张跃 on 14/11/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"

@interface SLWHomeViewController : UIViewController<ImagePlayerViewDelegate>
@property (nonatomic, strong) NSArray *imageURLs;
@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;

@end
