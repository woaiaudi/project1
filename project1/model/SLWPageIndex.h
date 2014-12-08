//
//  SLWPageIndex.h
//  project1
//
//  Created by 张跃 on 14/12/8.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLWPageIndex : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) Class controllerClass;

+ (instancetype)pageIndexWithTitle:(NSString *)title controllerClass:(Class)controllerClass;
@end
