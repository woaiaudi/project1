//
//  CompanyService.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyBean.h"
#import <AFNetworking.h>

@interface CompanyService : NSObject
-(void)getCompanyList:(NSString *)xxxx
             begin:(NSInteger)beginIndex
            offset:(NSInteger)offsetIndex
         onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock;

-(void)getCompanyDetailById:(NSString *)pId
               onsuccess:(void (^)(NSString * pBlockString))successedBlock
               onfailure:(void (^)(NSError *error))failedBlock;
@end
