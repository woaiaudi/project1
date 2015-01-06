//
//  NewsService.m
//  project1
//
//  Created by zyue on 14/12/24.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "NewsService.h"


@implementation NewsService
-(void)getNewsList:(NSString *)xxxx
            begin:(NSInteger)beginIndex
           offset:(NSInteger)offsetIndex
        onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
        onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=article_list",NSLocalizedString(@"BASEURL", "")];
    //带中文参数的 GET请求 要转码
    //urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *returnList = [NSMutableArray array];
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray * array = (NSArray *)responseObject;
            for (NSDictionary * bean in array)
            {
                [returnList addObject:[[NewsBean alloc] initWithDictionary:bean]];
            }
            successedBlock(returnList);
        }
        else
        {
            NSError *aError = [NSError errorWithDomain:MyErrorDomain code:XDefultFailed userInfo:[NSDictionary dictionaryWithObject:DefultFailedMessage forKey:NSLocalizedDescriptionKey]];
            failedBlock(aError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error);
    }];
}


-(void)getNewsDetailById:(NSString *)pId
         onsuccess:(void (^)(NSString * pBlockString))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=articlebyid&id=%@",NSLocalizedString(@"BASEURL", ""),pId];
    //请求 单纯二进制数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //需要转码成utf-8
        NSData *dataxx = responseObject;
        NSString *dataoo =  [[NSString alloc]initWithData:dataxx encoding:NSUTF8StringEncoding];
        successedBlock(dataoo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       failedBlock(error);
    }];
    
    
    
    
}


-(void)getTopNewsList:(NSString *)xxxx
         onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
         onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=article_top",NSLocalizedString(@"BASEURL", "")];
    //带中文参数的 GET请求 要转码
    //urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *returnList = [NSMutableArray array];
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray * array = (NSArray *)responseObject;
            for (NSDictionary * bean in array)
            {
                [returnList addObject:[[NewsBean alloc] initWithDictionary:bean]];
            }
            successedBlock(returnList);
        }
        else
        {
            NSError *aError = [NSError errorWithDomain:MyErrorDomain code:XDefultFailed userInfo:[NSDictionary dictionaryWithObject:DefultFailedMessage forKey:NSLocalizedDescriptionKey]];
            failedBlock(aError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error);
    }];
}
@end
