//
//  UserBean.h
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface UserBean : Jastor
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *usertype;
@property (nonatomic, copy) NSString *sex;
@end
