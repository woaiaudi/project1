//
//  SLWSupplyDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/16.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSupplyDetailViewController.h"
#import "GoodsService.h"
#import <TSMessage.h>
#import <UIImageView+WebCache.h>

@interface SLWSupplyDetailViewController ()
{
    GoodsService * goodsService;
}

@end

@implementation SLWSupplyDetailViewController
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
     [_goodsImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),goodsBean.imgurl]] placeholderImage:[UIImage imageNamed:@"noimg"]];
    
    _fengleiLabel.text = goodsBean.fenglei;
    _pingpaiLabel.text = goodsBean.pingpai;
    _xinghaoLabel.text = goodsBean.xinghao;
    _jiageLabel.text = goodsBean.jiage;
    _shuliangLabel.text = goodsBean.shuliang;
    _dianhuaLabel.text = goodsBean.tel;
    _shoujiLabel.text = goodsBean.mobile;
    _emailLabel.text = goodsBean.email;
    _timeLbael.text = goodsBean.addtime;
}

-(void)initCompanyInfo{

}


- (IBAction)companyURLAction:(id)sender {
    
}


-(void)initDetailInfo{
    [goodsService getGoodsDetailById:goodsBean.id onsuccess:^(NSString *pBlockString) {
        [_supplyDetailWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}
@end
