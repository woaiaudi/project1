//
//  UIHelper.m
//  project1
//
//  Created by zyue on 14/12/19.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UIHelper.h"
#import "HACLPage.h"

@implementation UIHelper
+(void)pushViewController:(Class)controllerClass andTitle:(NSString *)title byFromViewController:(UIViewController *)from
{
    // 1.取模型
    SLWPageIndex *pi =[SLWPageIndex pageIndexWithTitle:title controllerClass:[controllerClass class]];
    // 2.创建控制器
    UIViewController *vc = [[pi.controllerClass alloc] init];
    vc.title = pi.title;
    // 3.跳转
    [from.navigationController pushViewController:vc animated:YES];
   
}
+(void)popViewControllerAnimated:(UIViewController *)from
{
    [from.navigationController popViewControllerAnimated:YES];
}
+(void)popToRootViewControllerAnimated:(UIViewController *)from
{
    [from.navigationController popToRootViewControllerAnimated:YES];
}


+(void)showDetailBySupply:(GoodsBean *)supplyBean andFrom:(UIViewController *)from
{
    //文章段落
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //插图
    NSMutableIndexSet *clipIndex = [[NSMutableIndexSet alloc]init];
    
    
    
    //\n\n\t\t 可识别
    [items addObject:supplyBean.id];
    [items addObject:supplyBean.title];
    [items addObject:supplyBean.pingpai];
    [items addObject:supplyBean.xinghao];
    [items addObject:supplyBean.email];
    [items addObject:supplyBean.imgurl];
    
    NSString *bannerImageUrl =[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),supplyBean.imgurl];
    HACLTableViewPage * page1 = [[HACLTableViewPage alloc]initWithTitle:supplyBean.title head:bannerImageUrl topView:nil footTabbarItems:nil];
    
    [page1 setItems:items];
    [page1 setClipIndexSet:clipIndex];
    
    [from.navigationController pushViewController:page1 animated:YES];}

@end
