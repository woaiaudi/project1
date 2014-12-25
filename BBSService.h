//
//  BBSService.h
//  project1
//
//  Created by zyue on 14/12/25.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "BBSBean.h"

@interface BBSService : NSObject
-(void)getBBSList:(NSString *)xxxx
            begin:(NSInteger)beginIndex
           offset:(NSInteger)offsetIndex
        onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
        onfailure:(void (^)(NSError *error))failedBlock;
@end
