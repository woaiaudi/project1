//
//  SLWHome.m
//  project1
//
//  Created by zyue on 14/12/13.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWHome.h"
#import "SLWPageIndex.h"
#import "SLWSignUpViewController.h"
#import "SLWLoginViewController.h"
#import "SLWNewsListViewController.h"
#import "SLWSupplyListViewController.h"
#import "SLWCompanyListViewController.h"
#import "SLWSearchViewController.h"
#import "UIHelper.h"
#import "UserService.h"
#import <TSMessage.h>

@interface SLWHome ()
{
    //首页要跳转的页面
    NSMutableArray * pageIndexArray;
    
    
    NSArray *imageURLs;
}
@end

@implementation SLWHome

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"中国工程塑料";
    
    //右上角搜索按钮
    //左侧滑按钮
    UIBarButtonItem *rightButton1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchPage)];
    
    
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user.png"] style:UIBarButtonItemStyleDone target:self action:@selector(openLoginPage)];
    
// self.navigationItem.rightBarButtonItem = rightButton1;//////////////////搜索功能暂时不使用
    self.navigationItem.leftBarButtonItem = leftButton1;
    
    [self initAllPageIndexArray];
    [self addAOScrollerView:nil];
    [self initHomeImageButtons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化首页要跳转的页面数组
-(void)initAllPageIndexArray
{
    pageIndexArray = [NSMutableArray array];
    
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"信息咨询" controllerClass:[SLWNewsListViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"企业展示" controllerClass:[SLWCompanyListViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"产品供应" controllerClass:[SLWSupplyListViewController class]]];
    
}
#pragma mark - 将焦点图显示在页面上
-(void)addAOScrollerView:(NSArray *)array
{
    imageURLs = [NSArray array];
    imageURLs = @[[NSURL URLWithString:@"http://h.hiphotos.baidu.com/baike/pic/item/cdbf6c81800a19d8b3d02b5930fa828ba71e469e.jpg"],
                       [NSURL URLWithString:@"http://d.hiphotos.baidu.com/baike/pic/item/a71ea8d3fd1f4134f4437e23261f95cad1c85e72.jpg"],
                       [NSURL URLWithString:@"http://c.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26%3Bt%3Dgif/sign=e9614d120923dd54357eaf3ab060d8bb/7af40ad162d9f2d3755e1599a9ec8a136327cc7c.jpg"]];
    
    self.imagePlayerView.imagePlayerViewDelegate = self;
    
    // set auto scroll interval to x seconds
    self.imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    
    // adjust edgeInset
    //self.imagePlayerView.edgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    
    [self.imagePlayerView reloadData];
}
#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[imageURLs objectAtIndex:index]]];
    });
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"首页banner图片点击了 = %d", (int)index);
}

#pragma mark - 首页图片按钮
-(void)initHomeImageButtons
{
    __weak UIViewController *controller = self;
    __weak NSMutableArray *weakPageIndexArray =pageIndexArray;
    
    //   1
    [_leftButton setOnImageClickListener:^(UIImageView *clickedImage) {
        NSLog(@"_leftButton is clicked");
        // 1.取模型
        SLWPageIndex *pi =weakPageIndexArray[0];
        // 2.创建控制器
        UIViewController *vc = [[pi.controllerClass alloc] init];
        vc.title = pi.title;
        // 3.跳转
        [controller.navigationController pushViewController:vc animated:YES];
    }];
    
    //   2
    [_right1Button setOnImageClickListener:^(UIImageView *clickedImage) {
        NSLog(@"_leftButton is clicked");
        // 1.取模型
        SLWPageIndex *pi =weakPageIndexArray[1];
        // 2.创建控制器
        UIViewController *vc = [[pi.controllerClass alloc] init];
        vc.title = pi.title;
        // 3.跳转
        [controller.navigationController pushViewController:vc animated:YES];
    }];
    
    //   3
    [_right2Button setOnImageClickListener:^(UIImageView *clickedImage) {
        NSLog(@"_leftButton is clicked");
        // 1.取模型
        SLWPageIndex *pi =weakPageIndexArray[2];
        // 2.创建控制器
        UIViewController *vc = [[pi.controllerClass alloc] init];
        vc.title = pi.title;
        // 3.跳转
        [controller.navigationController pushViewController:vc animated:YES];
    }];
    
    
}
#pragma mark - 打开搜索
-(void)showSearchPage
{
    [UIHelper pushViewController:[SLWSearchViewController class] andTitle:@"搜索" byFromViewController:self];
}
#pragma mark - 打开登录页面
-(void)openLoginPage{
    UserService *us =  [[UserService alloc]init];
    UserBean *loginUser = [us getAccessedUserBean];
    if (loginUser!=nil) {
        //已经登录
        [TSMessage showNotificationInViewController:self
                                              title:@"提醒"
                                           subtitle:[NSString stringWithFormat:@"用户【%@】已经登录.",loginUser.username]
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationAutomatic
                                           callback:nil
                                        buttonTitle:@"注销"
                                     buttonCallback:^{
                                         [us deleteAccessedUserBean];
                                     }
                                         atPosition:TSMessageNotificationPositionTop
                               canBeDismissedByUser:YES];

    }
    else
    [UIHelper pushViewController:[SLWLoginViewController class] andTitle:@"用户登录" byFromViewController:self];
}
@end
