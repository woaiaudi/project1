//
//  BBSBean.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Jastor.h"
@interface BBSBean : Jastor
@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * createtime;
@property(nonatomic,copy) NSString * views;
@property(nonatomic,copy) NSString * replies;
@end
