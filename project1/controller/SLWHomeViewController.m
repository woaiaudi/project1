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
    //设置图片url数组
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    //设置标题数组
    NSMutableArray *strArr =[[NSMutableArray alloc] init];
    [imgArr addObject:@"http://www.sinaimg.cn/dy/slidenews/1_img/2014_47/2841_514655_319360.jpg"];
    [strArr addObject:@"图片1"];
    
    [imgArr addObject:@"http://www.sinaimg.cn/dy/slidenews/1_img/2014_47/2841_514656_666376.jpg"];
    [strArr addObject:@"图片2"];
    
    [imgArr addObject:@"http://www.sinaimg.cn/dy/slidenews/1_img/2014_47/2841_514657_236262.jpg"];
    [strArr addObject:@"图片3"];
   
    // 初始化自定义ScrollView类对象
    AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:imgArr titleArr:strArr frame:CGRectMake(0, 32, 320, 200)];
    //设置委托
    aSV.vDelegate=self;
    //添加进view
    [self.view addSubview:aSV];
}
-(void)buttonClick:(NSInteger)vid
{
    NSLog(@"xxxxxxx");
}

@end
