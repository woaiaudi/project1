//
//  UserService.h
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBean.h"
#import "HttpErrorBean.h"

@interface UserService : NSObject

-(void)loginByName:(NSString *)pName
               pwd:(NSString *)pPwd
         onsuccess:(void (^)(UserBean * pBlockBean))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock;


- (void)registerByUsername:(NSString *)pUsername
                  password:(NSString *)pPassword
                      pwdq:(NSString *)pPwdq
                      pwda:(NSString *)pPwda
                  realname:(NSString *)pRealname
                       sex:(NSString *)pSex
                   company:(NSString *)pCompany
                  usertype:(NSString *)pUsertype
                 onsuccess:(void (^)(UserBean * pBlockBean))successedBlock
                 onfailure:(void (^)(NSError *error))failedBlock;
@end
