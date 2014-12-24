//
//  UserService.m
//  project1
//
//  Created by zyue on 14/12/22.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "UserService.h"
#import <AFNetworking.h>
#import "JastorRuntimeHelper.h"
@implementation UserService

#define SLW_ACCESSED_USER @"slw_accessed_user"
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


-(void)saveAccessedUserBean:(UserBean *)userBean
{
    NSDictionary *userDic = [self convertFromObject:userBean];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userDic forKey:SLW_ACCESSED_USER];
    [defaults synchronize];//同步到 记录中
}

-(UserBean *)getAccessedUserBean
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:SLW_ACCESSED_USER]==nil) {
        //没有用户登录
        //提示没登陆，选择登陆或者注册
        return nil;
    }else
    {
        NSDictionary *userDic = (NSDictionary *)[defaults objectForKey:SLW_ACCESSED_USER];
        UserBean * resultbean = [[UserBean alloc]initWithDictionary:userDic];
        return resultbean;
    }
    
}
-(void)deleteAccessedUserBean
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:SLW_ACCESSED_USER];
    [defaults synchronize];//同步到 记录中
}
//自己添加的
- (NSMutableDictionary *)convertFromObject:(id)object{
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc] init];
    NSArray *array =[JastorRuntimeHelper propertyNames:[object class]];//获取所有的属性名称
    for (NSString *key in array) {
        [returnDic setValue:[object valueForKey:key] forKey:key];//从类里面取值然后赋给每个值，取得字典
    }
    return  returnDic ;
}
@end
