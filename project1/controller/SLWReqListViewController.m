//
//  SLWReqListViewController.m
//  project1
//
//  Created by zyue on 15/1/4.
//  Copyright (c) 2015年 esuliao. All rights reserved.
//

#import "SLWReqListViewController.h"
#import "MJRefresh.h"
#import "SLWSupplyListTableViewCell.h"
#import "GoodsBean.h"
#import "GoodsService.h"
#import <UIImageView+WebCache.h>
#import "UIHelper.h"
#import <TSMessage.h>
#import "SLWReqDetailViewController.h"


@interface SLWReqListViewController ()
{
    GoodsService * goodsService;
    NSMutableArray * reqList;
    TSLocateView *locateView;
}
@end

@implementation SLWReqListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    goodsService = [[GoodsService alloc]init];
    reqList = [NSMutableArray array];
    
   
    [self.reqTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.reqTableview setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
    // 1.注册cell
    [SLWSupplyListTableViewCell registerNibToTableView:self.reqTableview];
    
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
    [self.reqTableview addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.reqTableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.reqTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.reqTableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.reqTableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.reqTableview.headerRefreshingText = @"正在刷新中...";
    
    self.reqTableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.reqTableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.reqTableview.footerRefreshingText = @"正在加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //获取最新数据
    [goodsService requirementList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        //先清空
        [reqList removeAllObjects];
        [reqList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.reqTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.reqTableview headerEndRefreshing];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"远程服务器错误：%@",[error localizedDescription]] type:TSMessageNotificationTypeError];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.reqTableview headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    //加载更多数据
    [goodsService requirementList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        [reqList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.reqTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.reqTableview footerEndRefreshing];
    } onfailure:^(NSError *error) {
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"远程服务器错误：%@",[error localizedDescription]] type:TSMessageNotificationTypeError];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.reqTableview footerEndRefreshing];
    }];
    
}
#pragma mark - Table view UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SLWSupplyListTableViewCell heightForRow];
}
#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reqList.count;
}

- (SLWSupplyListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWSupplyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWSupplyListTableViewCell className] forIndexPath:indexPath];
    
    GoodsBean *thisBean = (GoodsBean *)[reqList objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = thisBean.title;
    cell.area.text = thisBean.area;
    cell.jiage.text = thisBean.jiage;
    cell.fenglei.text=thisBean.fenglei;
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),thisBean.imgurl]] placeholderImage:[UIImage imageNamed:@"noimg"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GoodsBean *thisBean = (GoodsBean *)[reqList objectAtIndex:indexPath.row];
    SLWReqDetailViewController *detailPage = [[SLWReqDetailViewController alloc]init];
    detailPage.title = @"需求详情";
    [detailPage setGoodsBean:thisBean];
    [self.navigationController pushViewController:detailPage animated:YES];
    
}
#pragma mark-地区选择
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
    }
}
- (IBAction)guigeAction:(id)sender {
}

- (IBAction)yongtuAction:(id)sender {
}

- (IBAction)diquActiion:(id)sender {
    if (!locateView) {
        locateView = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
    }
    [locateView showInView:self.view];
}
@end
