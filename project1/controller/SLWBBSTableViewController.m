//
//  SLWBBSTableViewController.m
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWBBSTableViewController.h"
#import "MJRefresh.h"
#import "UINavigationItem+CustomBackButton.h"
#import "BBSService.h"
#import "SLWBBSListTableViewCell.h"


@interface SLWBBSTableViewController ()
{
    NSMutableArray * bbsDataList;
    BBSService * bbsService;
}

@end

@implementation SLWBBSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //清除选中效果
    self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    bbsDataList = [NSMutableArray array];
    bbsService = [[BBSService alloc]init];
    
    
    // 1.注册cell
    [SLWBBSListTableViewCell registerNibToTableView:self.tableView];
    
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
    //获取最新数据
   
    [bbsService getBBSList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        //先清空
        [bbsDataList removeAllObjects];
        [bbsDataList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    } onfailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    //加载更多数据
    [bbsService getBBSList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        [bbsDataList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    } onfailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    }];
    
}
#pragma mark - Table view UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SLWBBSListTableViewCell heightForRow];
}
#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bbsDataList.count;
}

- (SLWBBSListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWBBSListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWBBSListTableViewCell className] forIndexPath:indexPath];
    
    BBSBean *thisBean = (BBSBean *)[bbsDataList objectAtIndex:indexPath.row];
    cell.titleLabel.text = thisBean.title;
    cell.viewLabel.text = thisBean.views;
    cell.messageLabel.text = thisBean.replies;
    cell.timeLabel.text = thisBean.createtime;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    GoodsBean *thisBean = (GoodsBean *)[self.supplyList objectAtIndex:indexPath.row];
//    [UIHelper showDetailBySupply:thisBean andFrom:self];
}
@end
