//
//  SLWRequriementDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/29.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWRequriementDetailViewController.h"

@interface SLWRequriementDetailViewController ()
{
     GoodsService * goodsService;
}

@end

@implementation SLWRequriementDetailViewController
@synthesize goodsBean;
- (void)viewDidLoad {
    [super viewDidLoad];
    goodsService = [[GoodsService alloc]init];
    
    [self initGoodsInfo];
    
    [self initCompanyInfo];
    
    [self initDetailInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initGoodsInfo{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),goodsBean.imgurl]] placeholderImage:[UIImage imageNamed:@"noimg"]];
    
    _leixingLabel.text = goodsBean.fenglei;
    _xinghaoLabel.text = goodsBean.xinghao;
    _shuliangLabel.text = goodsBean.shuliang;
    _difangLabel.text = goodsBean.area;
    _shuliangLabel.text = goodsBean.mobile;
    _emailLabel.text = goodsBean.email;
    _timeLabel.text = goodsBean.addtime;
    _jiageLabel.text = goodsBean.jiage;
    
}

-(void)initCompanyInfo{
    
}

- (IBAction)URLAction:(id)sender {
}
-(void)initDetailInfo{
    [goodsService getGoodsDetailById:goodsBean.id onsuccess:^(NSString *pBlockString) {
        [_detailWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}
@end
