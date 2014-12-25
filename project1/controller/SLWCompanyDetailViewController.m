//
//  SLWCompanyDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWCompanyDetailViewController.h"
#import <TSMessage.h>
#import "ACETelPrompt.h"

@interface SLWCompanyDetailViewController ()

@end

@implementation SLWCompanyDetailViewController
@synthesize companyBean;
- (void)viewDidLoad {
    [super viewDidLoad];
    CompanyService * companyService = [[CompanyService alloc]init];
    
    _companyLabel.text = companyBean.company;
    _linkerLabel.text = companyBean.linker;
    _linktelLabel.text = companyBean.linktel;
    
    if (![self isBlankString:companyBean.linktel]) {
        [_callButton setHidden:NO];
    }
    
    _emailLabel.text = companyBean.compemail;
    _zipLabel.text = companyBean.zip;
    _webaddLabel.text = companyBean.webaddr;
    _addressLabel.text = companyBean.compaddr;
    
    
    
    
    
    
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


- (IBAction)callAction:(id)sender {
    [ACETelPrompt callPhoneNumber:companyBean.linktel
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
