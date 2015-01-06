//
//  SLWBBSListViewController.m
//  project1
//
//  Created by zyue on 15/1/6.
//  Copyright (c) 2015年 esuliao. All rights reserved.
//

#import "SLWBBSListViewController.h"
#import "MJRefresh.h"
#import "UINavigationItem+CustomBackButton.h"
#import "BBSService.h"
#import "SLWBBSListTableViewCell.h"
#import "SLWBBSDetailViewController.h"
#import "SphereMenu.h"
@interface SLWBBSListViewController ()<SphereMenuDelegate>
{
    BBSService * bbsService;
}
@property(nonatomic,strong)NSMutableArray * bbsDataList;

@end

@implementation SLWBBSListViewController
-(NSMutableArray *)bbsDataList
{
    if (!_bbsDataList) {
        _bbsDataList = [NSMutableArray array];
    }
    return _bbsDataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //清除选中效果
    [self.bbsTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.bbsTableview setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    bbsService = [[BBSService alloc]init];
    
    
    // 1.注册cell
    [SLWBBSListTableViewCell registerNibToTableView:self.bbsTableview];
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    
    UIImage *startImage = [UIImage imageNamed:@"footicon.png"];
    UIImage *image1 = [UIImage imageNamed:@"huo_b.gif"];
    UIImage *image2 = [UIImage imageNamed:@"jinghua_b.gif"];
    UIImage *image3 = [UIImage imageNamed:@"tuijian_b.gif"];
    NSArray *images = @[image1, image2, image3];
    
    CGRect appFrame = [UIScreen mainScreen ].applicationFrame;
    
    SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake(appFrame.size.width-100, appFrame.size.height-44)
                                                         startImage:startImage
                                                      submenuImages:images];
    sphereMenu.delegate = self;
    [self.view addSubview:sphereMenu];
}
- (void)sphereDidSelected:(int)index
{
    [self.bbsTableview headerBeginRefreshing];
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
    [self.bbsTableview addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.bbsTableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.bbsTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.bbsTableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.bbsTableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.bbsTableview.headerRefreshingText = @"正在刷新中...";
    
    self.bbsTableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.bbsTableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.bbsTableview.footerRefreshingText = @"正在加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //获取最新数据
    
    [bbsService getBBSList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        //先清空
        [self.bbsDataList removeAllObjects];
        [self.bbsDataList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.bbsTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.bbsTableview headerEndRefreshing];
    } onfailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.bbsTableview headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    //加载更多数据
    [bbsService getBBSList:nil begin:0 offset:0 onsuccess:^(NSMutableArray *pBlockList) {
        [self.bbsDataList addObjectsFromArray:pBlockList];
        // 刷新表格
        [self.bbsTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.bbsTableview footerEndRefreshing];
    } onfailure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.bbsTableview footerEndRefreshing];
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
    return self.bbsDataList.count;
}

- (SLWBBSListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWBBSListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWBBSListTableViewCell className] forIndexPath:indexPath];
    
    BBSBean *thisBean = (BBSBean *)[self.bbsDataList objectAtIndex:indexPath.row];
    cell.titleLabel.text = thisBean.title;
    cell.viewLabel.text = thisBean.views;
    cell.messageLabel.text = thisBean.replies;
    cell.timeLabel.text = thisBean.createtime;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSBean *thisCellBean = [self.bbsDataList objectAtIndex:indexPath.row];
    SLWBBSDetailViewController * detailPage = [[SLWBBSDetailViewController alloc]init];
    [detailPage setTitle:thisCellBean.title];
    [detailPage setBbsId:thisCellBean.id];
    [self.navigationController pushViewController:detailPage animated:YES];
}
@end
