//
//  CompanyBean.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "Jastor.h"

@interface CompanyBean : Jastor
@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * group_id;
@property(nonatomic,copy) NSString * company;
@property(nonatomic,copy) NSString * linker;
@property(nonatomic,copy) NSString * linktel;
@property(nonatomic,copy) NSString * chuanzhen;
@property(nonatomic,copy) NSString * compemail;
@property(nonatomic,copy) NSString * zip;
@property(nonatomic,copy) NSString * webaddr;
@property(nonatomic,copy) NSString * compaddr;
@property(nonatomic,copy) NSString * logo;
@end
