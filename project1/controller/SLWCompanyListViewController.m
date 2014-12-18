//
//  SLWCompanyListViewController.m
//  project1
//
//  Created by zyue on 14/12/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWCompanyListViewController.h"
#import "MJRefresh.h"
/**
 *  随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机产品---%d", arc4random_uniform(1000000)]
@interface SLWCompanyListViewController ()
/**
 *  存放列表数据
 */
@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation SLWCompanyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataList = [NSMutableArray array];
    // 1.注册cell
    [SLWCompanyListTableViewCell registerNibToTableView:self.tableView];
    
    // 2.集成刷新控件
    [self setupRefresh];
    
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
    // 1.网列表数组  在表头添加最新数据
    //先清空
    [self.dataList removeAllObjects];
    for (int i = 0; i<5; i++) {
        [self.dataList insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.网列表数组  在表尾添加最新数据
    for (int i = 0; i<5; i++) {
        [self.dataList addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}
#pragma mark - Table view UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SLWCompanyListTableViewCell heightForRow];
}
#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (SLWCompanyListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWCompanyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWCompanyListTableViewCell className] forIndexPath:indexPath];
    cell.nameLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"test";
//}
@end
