//
//  HttpErrorBean.h
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface HttpErrorBean : Jastor
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, copy) NSString *msg;
@end
