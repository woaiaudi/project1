//
//  SLWCompanyDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWCompanyDetailViewController.h"
#import <TSMessage.h>

@interface SLWCompanyDetailViewController ()

@end

@implementation SLWCompanyDetailViewController
@synthesize companyBean;
- (void)viewDidLoad {
    [super viewDidLoad];
    CompanyService * companyService = [[CompanyService alloc]init];
    
    [companyService getCompanyDetailById:companyBean.id onsuccess:^(NSString *pBlockString) {
        [_companyWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
