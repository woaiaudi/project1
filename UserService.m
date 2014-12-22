//
//  UserService.m
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UserService.h"
#import <AFNetworking.h>
@implementation UserService

-(void)loginByName:(NSString *)pName
               pwd:(NSString *)pPwd
         onsuccess:(void (^)(UserBean * pBlockBean))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=user_login&username=%@&password=%@",NSLocalizedString(@"BASEURL", ""),pName,pPwd];
    //NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
   // [parameters setValue:[NSNumber numberWithInt:pUserType]  forKey:@"usertype"];
    //[parameters setValue:@"user_login" forKey:@"type"];
    

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            UserBean * returnBean = [[UserBean alloc]initWithDictionary:responseObject];
            successedBlock(returnBean);
        }
        else
        {
            NSError *aError = [NSError errorWithDomain:MyErrorDomain code:XLoginFailed userInfo:[NSDictionary dictionaryWithObject:@"登录失败"                                                                      forKey:NSLocalizedDescriptionKey]];
            failedBlock(aError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error);
    }];
    
}


- (void)registerUser:(NSString *)URLString
            usertype:(NSInteger)pUserType
            username:(NSString *)pUserName
                 pwd:(NSString *)pPwd
            realname:(NSString *)pRealName
           onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
           onfailure:(void (^)(NSError *error))failedBlock
{
    
}
@end
