//
//  SLWPageIndex.m
//  project1
//
//  Created by zyue on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "SLWPageIndex.h"

@implementation SLWPageIndex
+ (instancetype)pageIndexWithTitle:(NSString *)title controllerClass:(Class)controllerClass
{
    SLWPageIndex *pageIndex = [[self alloc] init];
    
    pageIndex.title = title;
    pageIndex.controllerClass = controllerClass;
    
    return pageIndex;
}
@end
