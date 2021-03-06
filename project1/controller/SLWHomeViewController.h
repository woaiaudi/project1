//
//  SLWHomeViewController.h
//  project1
//
//  Created by zyue on 14/11/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "AOScrollerView.h"
@interface SLWHomeViewController : UIViewController<ValueClickDelegate>

@property (strong, nonatomic) IBOutlet UIView *bannerView;


@property (nonatomic, strong) NSArray *imageURLs;
@property (weak, nonatomic) IBOutlet RKTabView *menuLine1;
@property (weak, nonatomic) IBOutlet RKTabView *menuLine2;

@end
