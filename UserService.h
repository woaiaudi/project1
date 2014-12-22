//
//  UserService.h
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBean.h"

@interface UserService : NSObject

-(void)loginByName:(NSString *)pName
               pwd:(NSString *)pPwd
         onsuccess:(void (^)(UserBean * pBlockBean))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock;


- (void)registerUser:(NSString *)URLString
            usertype:(NSInteger)pUserType
            username:(NSString *)pUserName
                 pwd:(NSString *)pPwd
            realname:(NSString *)pRealName
           onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
           onfailure:(void (^)(NSError *error))failedBlock;
@end
