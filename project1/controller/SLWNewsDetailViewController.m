//
//  SLWNewsDetailViewController.m
//  project1
//
//  Created by zyue on 14/12/24.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWNewsDetailViewController.h"
#import "NewsService.h"
#import <TSMessage.h>

@interface SLWNewsDetailViewController ()
{
    NewsService * newsService;
}

@end

@implementation SLWNewsDetailViewController
@synthesize newsId;
- (void)viewDidLoad {
    [super viewDidLoad];
    newsService = [[NewsService alloc]init];
    [newsService getNewsDetailById:newsId onsuccess:^(NSString *pBlockString) {
        [_newsWebview loadHTMLString:pBlockString baseURL:[NSURL URLWithString:NSLocalizedString(@"HOST", @"")]];
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
