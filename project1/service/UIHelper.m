//
//  UIHelper.m
//  project1
//
//  Created by zyue on 14/12/19.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UIHelper.h"
#import "HACLPage.h"
#import "ACETelPrompt.h"

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
    
    [items addObject:@"规格型号："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.xinghao]];
    
    [items addObject:@"供应价格："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.jiage]];
    
    [items addObject:@"供应数量："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.shuliang]];
    
    [items addObject:@"联系电话："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.tel]];
    
    [items addObject:@"手机号码："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.mobile]];
    
    [items addObject:@"电子邮件："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.email]];
    
    [items addObject:@"发布时间："];
    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.addtime]];
//    
//    [items addObject:@"产品详细说明："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.details]];
//    
//    [items addObject:@"所在地区："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.area]];
//    
//    [items addObject:@"期望价格："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.wantprice]];
//    
//    [items addObject:@"期望类型："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",supplyBean.wanttype]];
    
    
    NSString *bannerImageUrl =[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),supplyBean.imgurl];
    HACLTableViewPage * page1 = [[HACLTableViewPage alloc]initWithTitle:supplyBean.title head:bannerImageUrl topView:nil footTabbarItems:nil];
    
    [page1 setItems:items];
    [page1 setClipIndexSet:clipIndex];
    
    
    //打电话
    UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
    callBarButton.title = [UIHelper isBlankString:supplyBean.mobile]?supplyBean.tel:supplyBean.mobile;
    
    
    page1.navigationItem.rightBarButtonItem = callBarButton;
    
    [from.navigationController pushViewController:page1 animated:YES];
}

+(void)showDetailByRequirement:(GoodsBean *)reqBean andFrom:(UIViewController *)from
{
    //文章段落
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //插图
    NSMutableIndexSet *clipIndex = [[NSMutableIndexSet alloc]init];
    
    //\n\n\t\t 可识别
    //[items addObject:supplyBean.id];
    //[items addObject:[NSString stringWith
    //[items addObject:@"品牌："];
    //[items addObject:[NSString stringWithFormat:@"\t%@",reqBean.pingpai]];Format:@"\t\t%@",supplyBean.title]];
    
    [items addObject:@"求购类型："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.fenglei]];
    
    [items addObject:@"发布时间："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.addtime]];
    
    [items addObject:@"规格型号："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.xinghao]];
    
    [items addObject:@"需供应地："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.area]];
    
    [items addObject:@"求购数量："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.shuliang]];
    
    [items addObject:@"期望价格："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.wantprice]];

    [items addObject:@"手机号码："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.mobile]];
    
    [items addObject:@"电子邮件："];
    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.email]];
    
    
    
    
    
    
//    [items addObject:@"供应价格："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.jiage]];
//    
//    [items addObject:@"联系电话："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.tel]];
//    
//    [items addObject:@"产品详细说明："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.details]];
//    
//    items addObject:@"期望类型："];
//    [items addObject:[NSString stringWithFormat:@"\t%@",reqBean.wanttype]];
    
    
    NSString *bannerImageUrl =[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"HOST", ""),reqBean.imgurl];
    HACLTableViewPage * page1 = [[HACLTableViewPage alloc]initWithTitle:reqBean.title head:bannerImageUrl topView:nil footTabbarItems:nil];
    
    [page1 setItems:items];
    [page1 setClipIndexSet:clipIndex];
    
    
    //打电话
    UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
    callBarButton.title = [UIHelper isBlankString:reqBean.mobile]?reqBean.tel:reqBean.mobile;
    
    
    page1.navigationItem.rightBarButtonItem = callBarButton;
    
    [from.navigationController pushViewController:page1 animated:YES];
}


//类方法中 使用该@selector，所以这个方法也要定于成类方法
+(void)callAction:(UIBarButtonItem *)sender{
    NSLog(@"call >>> %@",sender.title);
    [ACETelPrompt callPhoneNumber:sender.title
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];
}
+(void)messageAction:(UIBarButtonItem *)sender{
    //弹出输入框，，，，，，，，，，，，，，，，，，，，，
}
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}





+(void)showAboutUsPage:(UIViewController *)from{
    //文章段落
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //插图
    NSMutableIndexSet *clipIndex = [[NSMutableIndexSet alloc]init];

    
    [items addObject:@"\t南京千域千寻网络科技有限公司是一家专业从事企业移动应用软件开发的高科技企业，进行各种移动化行业应用的定制开发与运营，帮助企业最快速、最低成本、动态化实现企业原有信息系统的移动化延伸。通过全面的数据集成技术和丰富的跨平台客户端展现能力,将业务系统快速、安全、高效的移植于移动终端，满足各种移动化功能需求。"];

    
    [items addObject:@"官方网站："];
    [items addObject:@"\thttp://www.jsqyqx.com/"];
    
    [items addObject:@"联系方式："];
    [items addObject:@"\t025--66078709\n\t南京市秦淮区中山东路198号\n\tjiangjunlin9@163.com\n"];
    
    
    
    HACLTableViewPage * page1 = [[HACLTableViewPage alloc]initWithTitle:@"关于我们" head:[UIImage imageNamed:@"absbanner.jpg"] topView:nil footTabbarItems:nil];
    
    [page1 setItems:items];
    [page1 setClipIndexSet:clipIndex];
    
    
    //打电话
    UIBarButtonItem *callBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"call.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callAction:)];
    callBarButton.title = @"025-66078709";
    
    
    UIBarButtonItem *messageBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message.png"] style:UIBarButtonItemStyleDone target:self action:@selector(messageAction:)];
    
    
    page1.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:callBarButton,messageBarButton, nil];
    
    [from.navigationController pushViewController:page1 animated:YES];
}
@end
