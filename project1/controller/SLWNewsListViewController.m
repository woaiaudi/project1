//
//  SLWNewsListViewController.m
//  project1
//
//  Created by zyue on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWNewsListViewController.h"
#import "MJRefresh.h"
#import "SLWNewsListTableViewCell.h"
#import "NewsService.h"
#import <UIImageView+WebCache.h>
#import "SLWNewsDetailViewController.h"
#import "UIHelper.h"
#import <TSMessage.h>

@interface SLWNewsListViewController ()
{
    NewsService *newsService;
}
/**
 *  存放列表数据
 */
@property (strong, nonatomic) NSMutableArray *newsList;
@end

@implementation SLWNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    newsService = [[NewsService alloc]init];
    _newsList = [NSMutableArray array];
    
    // 1.注册cell
    [SLWNewsListTableViewCell registerNibToTableView:self.tableView];
    
    // 2.集成刷新控件
    [self setupRefresh];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //获取最新数据
    [newsService getNewsList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        //先清空
        [self.newsList removeAllObjects];
        [self.newsList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"远程服务器错误：%@",[error localizedDescription]] type:TSMessageNotificationTypeError];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    //加载更多数据
    [newsService getNewsList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        [self.newsList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"远程服务器错误：%@",[error localizedDescription]] type:TSMessageNotificationTypeError];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    }];
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
    return self.newsList.count;
}

- (SLWNewsListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWNewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWNewsListTableViewCell className] forIndexPath:indexPath];
    NewsBean *thisCellBean = [self.newsList objectAtIndex:indexPath.row];
    cell.newsTitleLabel.text = thisCellBean.title;
    cell.newsTimeLabel.text = thisCellBean.add_time;
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),thisCellBean.img_url]] placeholderImage:[UIImage imageNamed:@"noimg"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NewsBean *thisCellBean = [self.newsList objectAtIndex:indexPath.row];
    SLWNewsDetailViewController * detailPage = [[SLWNewsDetailViewController alloc]init];
    [detailPage setTitle:thisCellBean.title];
    [detailPage setNewsId:thisCellBean.id];
    [self.navigationController pushViewController:detailPage animated:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"test";
//}
@end
