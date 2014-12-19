//
//  UINavigationItem+CustomBackButton.m
//  project1
//
//  Created by zyue on 14/12/18.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UINavigationItem+CustomBackButton.h"

@implementation UINavigationItem (CustomBackButton)
-(UIBarButtonItem *)backBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:NULL];
}
@end
