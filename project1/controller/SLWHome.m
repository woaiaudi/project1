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
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"供应管理" controllerClass:[SLWCompanyListViewController class]]];
    [pageIndexArray addObject:[SLWPageIndex pageIndexWithTitle:@"用户注册" controllerClass:[SLWSupplyListViewController class]]];
    
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
@end
