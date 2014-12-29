//
//  NewsService.h
//  project1
//
//  Created by zyue on 14/12/24.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsBean.h"
#import <AFNetworking.h>
@interface NewsService : NSObject
-(void)getNewsList:(NSString *)xxxx
             begin:(NSInteger)beginIndex
            offset:(NSInteger)offsetIndex
         onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock;

-(void)getNewsDetailById:(NSString *)pId
               onsuccess:(void (^)(NSString * pBlockString))successedBlock
               onfailure:(void (^)(NSError *error))failedBlock;


-(void)getTopNewsList:(NSString *)xxxx
            onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
            onfailure:(void (^)(NSError *error))failedBlock;
@end
