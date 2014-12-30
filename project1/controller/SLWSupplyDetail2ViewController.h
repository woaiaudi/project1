//
//  SLWSupplyDetail2ViewController.h
//  project1
//
//  Created by zyue on 14/12/30.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsBean.h"
@interface SLWSupplyDetail2ViewController : UIViewController
@property(nonatomic,retain) GoodsBean * goodsBean;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;


@property (strong, nonatomic) IBOutlet UIImageView *goodsImageview;
@property (strong, nonatomic) IBOutlet UILabel *fenleiLabel;
@property (strong, nonatomic) IBOutlet UILabel *pingpaiLabel;
@property (strong, nonatomic) IBOutlet UILabel *xinghaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiageLabel;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (strong, nonatomic) IBOutlet UILabel *shoujiLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *shijianLabel;


@property (strong, nonatomic) IBOutlet UILabel *linkerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkerTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyURLLabel;
- (IBAction)companyURLAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *companyAddressLabel;


@property (strong, nonatomic) IBOutlet UIWebView *detailWebview;



@end
