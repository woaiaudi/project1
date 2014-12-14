//
//  SLWSupplyListViewController.m
//  project1
//
//  Created by zyue on 14/12/14.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWSupplyListViewController.h"
#import "MJRefresh.h"
#import "SLWSupplyListTableViewCell.h"
/**
 *  随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机产品---%d", arc4random_uniform(1000000)]
@interface SLWSupplyListViewController ()
{
    NIDropDown * dropDown;
}
/**
 *  存放列表数据
 */
@property (strong, nonatomic) NSMutableArray *supplyList;
@end

@implementation SLWSupplyListViewController
//@synthesize supplyList;
- (void)viewDidLoad {
    [super viewDidLoad];
    _supplyList = [NSMutableArray array];
    // 1.注册cell
    [SLWSupplyListTableViewCell registerNibToTableView:self.supplyTableview];
    
    // 2.集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)yongtuButtonAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    //不能超过11个汉字
    arr = [NSArray arrayWithObjects:@"好问问很长很长很长很长", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
}

- (IBAction)diquButtonAction:(id)sender {
    UIButton * btnSender = (UIButton *)sender;
    //[btnSender setBackgroundImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
    [btnSender setTitle:@"xxsd" forState:UIControlStateNormal];
}

- (IBAction)guigeButtonAction:(id)sender {
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender byClickedButton:(UIButton *)button selectedIndex:(NSIndexPath *)index
{

    dropDown = nil;
    NSLog(@"点击了按钮【%d】后，选中了S[%d],R[%d]",button.tag,index.section,index.row);
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.supplyTableview addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.supplyTableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.supplyTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.supplyTableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.supplyTableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.supplyTableview.headerRefreshingText = @"正在刷新中...";
    
    self.supplyTableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.supplyTableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.supplyTableview.footerRefreshingText = @"正在加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.网列表数组  在表头添加最新数据
    //先清空
    [self.supplyList removeAllObjects];
    for (int i = 0; i<5; i++) {
        [self.supplyList insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.supplyTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.supplyTableview headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.网列表数组  在表尾添加最新数据
    for (int i = 0; i<5; i++) {
        [self.supplyList addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.supplyTableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.supplyTableview footerEndRefreshing];
    });
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
    return self.supplyList.count;
}

- (SLWSupplyListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWSupplyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SLWSupplyListTableViewCell className] forIndexPath:indexPath];
    cell.nameLabel.text = self.supplyList[indexPath.row];
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
