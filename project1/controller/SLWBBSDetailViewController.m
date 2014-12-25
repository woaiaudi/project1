//
//  SLWBBSDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWBBSDetailViewController.h"
#import "BBSService.h"
#import <TSMessage.h>

@interface SLWBBSDetailViewController ()

@end

@implementation SLWBBSDetailViewController
@synthesize bbsId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    BBSService * bbsService = [[BBSService alloc]init];
    [bbsService getBBSDetailById:bbsId onsuccess:^(NSString *pBlockString) {
        [_bbsWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:@"获取远程数据失败"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
