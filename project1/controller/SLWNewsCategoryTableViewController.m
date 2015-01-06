//
//  SLWNewsCategoryTableViewController.m
//  project1
//
//  Created by zyue on 15/1/3.
//  Copyright (c) 2015年 esuliao. All rights reserved.
//

#import "SLWNewsCategoryTableViewController.h"
#import "SLWNewsListTableViewCell.h"
#import "UIHelper.h"
#import "SLWNewsListViewController.h"


@interface SLWNewsCategoryTableViewController ()
{
    NSMutableArray * newCategoryList;
}

@end

@implementation SLWNewsCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    
    newCategoryList = [NSMutableArray array];
    NewsCategoryBean *nc1 = [[NewsCategoryBean alloc]init];
    nc1.id = @"1";
    nc1.title = @"最新资讯";
    nc1.img_url = @"home_tabitem_4.png";
    [newCategoryList addObject:nc1];
    
    nc1 = [[NewsCategoryBean alloc]init];
    nc1.id = @"2";
    nc1.title = @"塑料新闻";
    nc1.img_url = @"home_tabitem_5.png";
    [newCategoryList addObject:nc1];
    
    nc1 = [[NewsCategoryBean alloc]init];
    nc1.id = @"3";
    nc1.title = @"行业相关";
    nc1.img_url = @"home_tabitem_6.png";
    [newCategoryList addObject:nc1];
    
    nc1 = [[NewsCategoryBean alloc]init];
    nc1.id = @"4";
    nc1.title = @"国际资讯";
    nc1.img_url = @"home_tabitem_7.png";
    [newCategoryList addObject:nc1];
    
    
    [SLWNewsListTableViewCell registerNibToTableView:self.tableView];
    [self.tableView reloadData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SLWNewsListTableViewCell heightForRow];
}
#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newCategoryList.count;
}

- (SLWNewsListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWNewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWNewsListTableViewCell className] forIndexPath:indexPath];
    
    NewsCategoryBean *thisCellBean = [newCategoryList objectAtIndex:indexPath.row];
    cell.newsTitleLabel.text = thisCellBean.title;
    [cell.newsTimeLabel setHidden:YES];
    [cell.newsImageView setImage:[UIImage imageNamed:thisCellBean.img_url]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCategoryBean *thisCellBean = [newCategoryList objectAtIndex:indexPath.row];
    [UIHelper pushViewController:[SLWNewsListViewController class] andTitle:thisCellBean.title byFromViewController:self];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"test";
//}
@end
