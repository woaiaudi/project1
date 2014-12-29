//
//  GoodsService.h
//  project1
//
//  Created by zyue on 14/12/23.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsBean.h"
@interface GoodsService : NSObject
-(void)supplyList:(NSString *)xxxx
            begin:(NSInteger)beginIndex
           offset:(NSInteger)offsetIndex
        onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
        onfailure:(void (^)(NSError *error))failedBlock;
-(void)requirementList:(NSString *)xxxx
                 begin:(NSInteger)beginIndex
                offset:(NSInteger)offsetIndex
             onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
             onfailure:(void (^)(NSError *error))failedBlock;
-(void)getGoodsDetailById:(NSString *)pId
                onsuccess:(void (^)(NSString * pBlockString))successedBlock
                onfailure:(void (^)(NSError *error))failedBlock;
@end
