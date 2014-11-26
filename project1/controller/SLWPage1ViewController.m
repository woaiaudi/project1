//
//  SLWPage1ViewController.m
//  project1
//
//  Created by 张跃 on 14/11/26.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWPage1ViewController.h"

NSString *const Page1TableviewCellIdentifier = @"Page1TableviewCellIdentifier";

@interface SLWPage1ViewController ()

@end

@implementation SLWPage1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Page1TableviewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Page1TableviewCellIdentifier];
    }
    cell.textLabel.text = @"AAA";
    return  cell;
}
#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 》section:%d > row:%d",indexPath.section,indexPath.row);
}
@end
