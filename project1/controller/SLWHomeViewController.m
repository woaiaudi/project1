//
//  SLWHomeViewController.m
//  project1
//
//  Created by zyue on 14/11/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWHomeViewController.h"
#import "SLWPageIndex.h"
#import "SLWPage1ViewController.h"
#import "SLWSignUpViewController.h"
#import "SLWLoginViewController.h"
#import "SLWNewsListViewController.h"

@interface SLWHomeViewController ()
{
    NSMutableArray * pageIndexArray;
}

@end

@implementation SLWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAllPageIndexArray];
    [self addAOScrollerView:nil];
    
    [self initRKTabView];
}
-(void)viewWillAppear:(BOOL)animated{
    //NSLog(@"%@",NSStringFromCGRect(self.menuLine1.frame));
    self.menuLine1.frame = CGRectMake(0, 0, 320, 100);
    self.menuLine1.frame = CGRectMake(0, 100, 320, 50);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- AOScrollViewDelegate ValueClickDelegate 首页banner 点击事件
-(void)buttonClick:(int)vid{
    
}
#pragma mark - 将焦点图显示在页面上
-(void)addAOScrollerView:(NSArray *)array
{
    //设置图片url数组
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    //设置标题数组
    NSMutableArray *strArr =[[NSMutableArray alloc] init];
    [imgArr addObject:@"http://gcsl.gotoip4.com/upload/201412/10/201412102202117160.jpg"];
    [strArr addObject:@"产品新闻标题111111"];
    [imgArr addObject:@"http://gcsl.gotoip4.com/upload/201412/10/201412102244016426.jpg"];
    [strArr addObject:@"产品新闻标题222222"];
    // 初始化自定义ScrollView类对象
    AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:imgArr titleArr:strArr height:self.bannerView.bounds.size.height];
    //设置委托
    aSV.vDelegate=self;
    //添加进view
    [self.bannerView addSubview:aSV];
}
#pragma mark - 初始化首页要跳转的页面数组
-(void)initAllPageIndexArray
{
    pageIndexArray = [NSMutableArray array];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"供求管理" controllerClass:[SLWPage1ViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"信息咨询" controllerClass:[SLWNewsListViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"企业展示" controllerClass:[SLWPage1ViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"全部分类" controllerClass:[SLWPage1ViewController class]]];
   
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"检索" controllerClass:[SLWPage1ViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"行业论坛" controllerClass:[SLWPage1ViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"用户中心" controllerClass:[SLWLoginViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"关于我们" controllerClass:[SLWPage1ViewController class]]];

}

#pragma mark- 初始化tabbar
-(void)initRKTabView
{
    //图标大小44*44 为合适的
    RKTabItem *HomeTabItem1 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_1"]];
    HomeTabItem1.titleString = @"供求管理";
    RKTabItem *HomeTabItem2 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_2"]];
    HomeTabItem2.titleString = @"信息咨询";
    RKTabItem *HomeTabItem3 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_3"]];
    HomeTabItem3.titleString = @"企业展示";
    RKTabItem *HomeTabItem4 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_4"]];
    HomeTabItem4.titleString = @"全部分类";
    
    RKTabItem *HomeTabItem5 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_5"]];
    HomeTabItem5.titleString = @"检索";
    RKTabItem *HomeTabItem6 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_6"]];
    HomeTabItem6.titleString = @"行业论坛";
    RKTabItem *HomeTabItem7 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_7"]];
    HomeTabItem7.titleString = @"用户中心";
    RKTabItem *HomeTabItem8 = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"home_tabitem_8"]];
    HomeTabItem8.titleString = @"关于我们";
    
    
    //mastercardTabItem.tabState = TabStateEnabled;
    
    self.menuLine1.darkensBackgroundForEnabledTabs = YES;//点击时没有效果
    self.menuLine1.horizontalInsets = HorizontalEdgeInsetsMake(10, 10);//左边和右边预留的 宽度
    self.menuLine1.titlesFontColor = [UIColor blackColor];
    self.menuLine1.titlesFont = [UIFont fontWithName:@"Heiti SC" size:15.0];
    //    self.spotDetailTabbar.backgroundColor = [UIColor colorWithRed:0 green:121.0 blue:0 alpha:0.5f];
    self.menuLine1.tabItems = @[HomeTabItem1, HomeTabItem2, HomeTabItem3,HomeTabItem4];
    
    self.menuLine2.darkensBackgroundForEnabledTabs = YES;//点击时没有效果
    self.menuLine2.horizontalInsets = HorizontalEdgeInsetsMake(10, 10);//左边和右边预留的 宽度
    self.menuLine2.titlesFontColor = [UIColor blackColor];
    self.menuLine2.titlesFont = [UIFont fontWithName:@"Heiti SC" size:15.0];
    //    self.spotDetailTabbar.backgroundColor = [UIColor colorWithRed:0 green:121.0 blue:0 alpha:0.5f];
    self.menuLine2.tabItems = @[HomeTabItem5, HomeTabItem6, HomeTabItem7,HomeTabItem8];
}
#pragma mark - RKTabViewDelegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    tabItem.tabState = TabStateDisabled;//设置按钮状态为 可点击按钮 TabStateEnabled/TabStateDisabled
    
    // 1.取出模型
    SLWPageIndex *pi =nil;
    
    if (tabView.tag == 99901) {
        //第一排按钮
        pi = pageIndexArray[index];
    }
    if (tabView.tag == 99902) {
        //第二排按钮
        pi = pageIndexArray[index+4];
    }
    
    // 2.创建控制器
    UIViewController *vc = [[pi.controllerClass alloc] init];
    vc.title = pi.title;
    // 3.跳转
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}
@end
