//
//  SLWRequriementDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/29.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWRequriementDetailViewController.h"
#import "ACETelPrompt.h"
#import "TOWebViewController.h"
#import "UIHelper.h"

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
    [goodsService getCompanyByID:goodsBean.addid onsuccess:^(NSDictionary *pBlockDic) {
        _compnyNameLabel.text = [pBlockDic objectForKey:@"_company"];
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

- (IBAction)URLAction:(id)sender {
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
        [_detailWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}
@end
