//
//  SLWHomeViewController.m
//  project1
//
//  Created by 张跃 on 14/11/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWHomeViewController.h"

@interface SLWHomeViewController ()

@end

@implementation SLWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAOScrollerView:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 将焦点图显示在页面上
-(void)addAOScrollerView:(NSArray *)array
{
    self.imageURLs = @[[NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/2_img/2014_47/786_1382457_499452.jpg"],
                       [NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/2_img/2014_47/786_1382463_199708.jpg"],
                       [NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/2_img/2014_47/786_1382390_215863.jpg"]];
    
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
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.imageURLs objectAtIndex:index]]];
    });
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}

@end
