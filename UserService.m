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
            NSDictionary * dic = (NSDictionary *)responseObject;
            
            if ([@"1" isEqualToString:[dic objectForKey:@"status"]]) {
                UserBean * returnBean = [[UserBean alloc]initWithDictionary:responseObject];
                successedBlock(returnBean);
            }
            else
            {
                HttpErrorBean * httpErrorBean = [[HttpErrorBean alloc]initWithDictionary:dic];
                NSError *aError = [NSError errorWithDomain:MyErrorDomain code:XLoginFailed userInfo:[NSDictionary dictionaryWithObject:httpErrorBean.msg                                                                      forKey:NSLocalizedDescriptionKey]];
                failedBlock(aError);
            }
            
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


- (void)registerByUsername:(NSString *)pUsername
                  password:(NSString *)pPassword
                      pwdq:(NSString *)pPwdq
                      pwda:(NSString *)pPwda
                  realname:(NSString *)pRealname
                       sex:(NSString *)pSex
                   company:(NSString *)pCompany
                  usertype:(NSString *)pUsertype
                 onsuccess:(void (^)(UserBean * pBlockBean))successedBlock
                 onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=user_register&username=%@&password=%@&pwdq=%@&pwda=%@&realname=%@&sex=%@&company=%@&usertype=%@",NSLocalizedString(@"BASEURL", ""),pUsername,pPassword,pPwdq,pPwda,pRealname,pSex,pCompany,pUsertype];
    //带中文参数的 GET请求 要转码
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * dic = (NSDictionary *)responseObject;
            
            if ([@"1" isEqualToString:[dic objectForKey:@"status"]]) {
                UserBean * returnBean = [[UserBean alloc]initWithDictionary:responseObject];
                successedBlock(returnBean);
            }
            else
            {
                HttpErrorBean * httpErrorBean = [[HttpErrorBean alloc]initWithDictionary:dic];
                NSError *aError = [NSError errorWithDomain:MyErrorDomain code:XRegisterFailed userInfo:[NSDictionary dictionaryWithObject:httpErrorBean.msg                                                                      forKey:NSLocalizedDescriptionKey]];
                failedBlock(aError);
            }
            
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
@end
