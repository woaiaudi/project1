//
//  UIHelper.m
//  project1
//
//  Created by zyue on 14/12/19.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UIHelper.h"

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
@end
