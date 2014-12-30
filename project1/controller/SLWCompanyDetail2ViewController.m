//
//  SLWCompanyDetail2ViewController.m
//  project1
//
//  Created by zyue on 14/12/30.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWCompanyDetail2ViewController.h"
#import <TSMessage.h>
#import "ACETelPrompt.h"
#import "TOWebViewController.h"
#import "UIHelper.h"
#import <UIImageView+WebCache.h>

@interface SLWCompanyDetail2ViewController ()

@end

@implementation SLWCompanyDetail2ViewController
@synthesize companyBean;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollView setContentSize:_contentView.frame.size];
    [_scrollView addSubview:_contentView];
    
    CompanyService * companyService = [[CompanyService alloc]init];
    _companyLabel.text = companyBean.company;
    _linkerLabel.text = companyBean.linker;
    _linkerTelLabel.text = companyBean.linktel;
    
    if (![UIHelper isBlankString:companyBean.linktel]) {
        [_callButton setHidden:NO];
    }
    
    _emailLabel.text = companyBean.compemail;
    _zipLabel.text = companyBean.zip;
    _companyURLLabel.text = companyBean.webaddr;
    _companyAddressLabel.text = companyBean.compaddr;
    [_companyImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),companyBean.logo]] placeholderImage:[UIImage imageNamed:@"noimg"]];
    
    [_vipMarkImageview setHidden:([companyBean.group_id isEqualToString:@"2"]?NO:YES)];
    
    
    
    
    [companyService getCompanyDetailById:companyBean.id onsuccess:^(NSString *pBlockString) {
        [_detailWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)callAction:(id)sender {
    [ACETelPrompt callPhoneNumber:companyBean.linktel
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];
}

- (IBAction)companyURLAction:(id)sender {
    NSString * urlStr = _companyURLLabel.text;
    NSLog(@"url:%@",urlStr);
    if (![UIHelper isBlankString:urlStr]) {
        NSURL * actionURL = [NSURL URLWithString:urlStr];
        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:actionURL];
        [self.navigationController pushViewController:webViewController animated:YES];
        
    }
}
@end
