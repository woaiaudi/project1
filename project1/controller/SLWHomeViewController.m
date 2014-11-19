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
    // Do any additional setup after loading the view from its nib.
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
    [imgArr addObject:thisBean.coverpic];
    [strArr addObject:thisBean.spotName];
    
    [imgArr addObject:thisBean.coverpic];
    [strArr addObject:thisBean.spotName];
    
    [imgArr addObject:thisBean.coverpic];
    [strArr addObject:thisBean.spotName];
   
    // 初始化自定义ScrollView类对象
    AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:imgArr titleArr:strArr height:self.bannerView.bounds.size.height];
    //设置委托
    aSV.vDelegate=self;
    //添加进view
    [self.bannerView addSubview:aSV];
}


@end
