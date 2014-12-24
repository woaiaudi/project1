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
    //[items addObject:supplyBean.id];
    //[items addObject:[NSString stringWithFormat:@"\t\t%@",supplyBean.title]];
    [items addObject:@"品牌："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.pingpai]];
    
    [items addObject:@"产品分类："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.fenglei]];
    
    [items addObject:@"产品型号："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.xinghao]];
    
    [items addObject:@"产品价格："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.jiage]];
    
    [items addObject:@"产品数量："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.shuliang]];
    
    [items addObject:@"联系电话："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.tel]];
    
    [items addObject:@"手机号码："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.mobile]];
    
    [items addObject:@"电子邮件："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.email]];
    
    [items addObject:@"添加时间："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.addtime]];
    
    [items addObject:@"产品详细说明："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.details]];
    
    [items addObject:@"所在地区："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.area]];
    
    [items addObject:@"期望价格："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.wantprice]];
    
    [items addObject:@"期望类型："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.wanttype]];
    
    
    NSString *bannerImageUrl =[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),supplyBean.imgurl];
    HACLTableViewPage * page1 = [[HACLTableViewPage alloc]initWithTitle:supplyBean.title head:bannerImageUrl topView:nil footTabbarItems:nil];
    
    [page1 setItems:items];
    [page1 setClipIndexSet:clipIndex];
    
    [from.navigationController pushViewController:page1 animated:YES];
}

@end
