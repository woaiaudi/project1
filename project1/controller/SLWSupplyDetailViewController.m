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
#import "ACETelPrompt.h"
#import "TOWebViewController.h"
#import "UIHelper.h"

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
    
    //打电话
    UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
    callBarButton.title = [UIHelper isBlankString:goodsBean.mobile]?goodsBean.tel:goodsBean.mobile;
    
    
    self.navigationItem.rightBarButtonItem = callBarButton;
    
    
    
    [self initGoodsInfo];
    
    [self initCompanyInfo];
    
    [self initDetailInfo];
    
}

-(void)callAction:(UIBarButtonItem *)sender{
    NSLog(@"call >>> %@",sender.title);
    [ACETelPrompt callPhoneNumber:sender.title
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];
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
    [goodsService getCompanyByID:goodsBean.addid onsuccess:^(NSDictionary *pBlockDic) {
//        "_address": "",
//        "_amount": 0,
//        "_avatar": "/upload/201412/08/201412081957062079.jpg",
//        "_birthday": null,
//        "_chuanzhen": "82737896",
//        "_compaddr": "另外克己复礼阿斯兰多夫空军",
//        "_company": "公司名称公司名称",
//        "_companydetails": null,
//        "_compemail": "111@qq.com",
//        "_email": "123@qq.com",
//        "_exp": 0,
//        "_group_id": 1,
//        "_id": 1,
//        "_linker": "张三",
//        "_linktel": "1231230981",
//        "_logo": "/upload/201412/11/201412112352050077.jpg",
//        "_mobile": "15861756826",
//        "_nick_name": "12",
//        "_password": "D7A0ECB9E84EFE49",
//        "_point": 22,
//        "_qq": "",
//        "_reg_ip": "127.0.0.1",
//        "_reg_time": "/Date(1416925074000+0800)/",
//        "_safe_answer": "",
//        "_safe_question": "",
//        "_salt": "4DF42N",
//        "_sex": "保密",
//        "_status": 0,
//        "_telphone": "",
//        "_user_name": "zhujiamian",
//        "_user_type": "经销商",
//        "_webaddr": "12.web.com",
//        "_zip": "223001"
        _companyNameLabel.text = [pBlockDic objectForKey:@"_company"];
        _linkerNameLabel.text= [pBlockDic objectForKey:@"_linker"];
        _linkerTelLabel.text =[pBlockDic objectForKey:@"_linktel"];
         _companyAddressLabel.text =[pBlockDic objectForKey:@"_compaddr"];

        [_companyURLLabel setTitle:[pBlockDic objectForKey:@"_webaddr"] forState:UIControlStateNormal];
        [_companyURLLabel setTitle:[pBlockDic objectForKey:@"_webaddr"] forState:UIControlStateHighlighted];
        
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取公司信息失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];

}


- (IBAction)companyURLAction:(id)sender {
    NSString * urlStr = [_companyURLLabel titleForState:UIControlStateHighlighted];
    NSLog(@"url:%@",urlStr);
    if (urlStr!= nil&&urlStr.length>5) {
        NSURL * actionURL = [NSURL URLWithString:urlStr];
        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:actionURL];
        [self.navigationController pushViewController:webViewController animated:YES];
        
    }

}


-(void)initDetailInfo{
    [goodsService getGoodsDetailById:goodsBean.id onsuccess:^(NSString *pBlockString) {
        [_supplyDetailWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取详细信息失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}

//打电话
//[ACETelPrompt callPhoneNumber:_companyURLLabel.titleLabel.text
//                         call:^(NSTimeInterval duration) {
//                             NSLog(@"User made a call of %.1f seconds", duration);
//                             
//                         } cancel:^{
//                             NSLog(@"User cancelled the call");
//                         }];
@end
