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
#pragma mark - Table view UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [SLWBBSListTableViewCell heightForRow];
//}
#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"最新回复";
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:TableSampleIdentifier];
    }
    
    cell.textLabel.text = @"sdsdlk:sdakjah";
    cell.detailTextLabel.text = @"2014-12-25";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
