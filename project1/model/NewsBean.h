//
//  NewsBean.h
//  project1
//
//  Created by zyue on 14/12/24.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface NewsBean : Jastor
@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * img_url;
@property(nonatomic,copy) NSString * add_time;

@end
