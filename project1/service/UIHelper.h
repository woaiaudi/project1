//
//  UIHelper.h
//  project1
//
//  Created by zyue on 14/12/19.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLWPageIndex.h"
#import "GoodsBean.h"
@interface UIHelper : NSObject
+(void)pushViewController:(Class)controllerClass andTitle:(NSString *)title byFromViewController:(UIViewController *)from;

+(void)popViewControllerAnimated:(UIViewController *)from;
+(void)popToRootViewControllerAnimated:(UIViewController *)from;


+(void)showDetailBySupply:(GoodsBean *)supplyBean andFrom:(UIViewController *)from;
+(void)showDetailByRequirement:(GoodsBean *)reqBean andFrom:(UIViewController *)from;
+(void)callAction:(UIBarButtonItem *)sender;
+ (BOOL)isBlankString:(NSString *)string;
@end
