//
//  SLWRequriementDetailViewController.h
//  project1
//
//  Created by zyue on 14/12/29.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsService.h"
#import <TSMessage.h>
#import <UIImageView+WebCache.h>

@interface SLWRequriementDetailViewController : UIViewController

@property(nonatomic,retain) GoodsBean * goodsBean;

@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *leixingLabel;
@property (strong, nonatomic) IBOutlet UILabel *xinghaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *difangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shoujiLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiageLabel;


@property (strong, nonatomic) IBOutlet UILabel *compnyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerTelLabel;
@property (strong, nonatomic) IBOutlet UIButton *companyURLLabel;
- (IBAction)URLAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *companyAddressLabel;



@property (strong, nonatomic) IBOutlet UIWebView *detailWebview;

@end
