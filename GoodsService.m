//
//  GoodsService.m
//  project1
//
//  Created by zyue on 14/12/23.
//  Copyright (c) 2014年 esuliao. All rights reserved.
//

#import "GoodsService.h"
#import "GoodsBean.h"
#import <AFNetworking.h>

@implementation GoodsService

-(void)supplyList:(NSString *)xxxx
                 begin:(NSInteger)beginIndex
                offset:(NSInteger)offsetIndex
             onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
             onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=supply_goods",NSLocalizedString(@"BASEURL", "")];
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
                [returnList addObject:[[GoodsBean alloc] initWithDictionary:bean]];
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


-(void)requirementList:(NSString *)xxxx
                 begin:(NSInteger)beginIndex
                offset:(NSInteger)offsetIndex
             onsuccess:(void (^)(NSMutableArray * pBlockList))successedBlock
             onfailure:(void (^)(NSError *error))failedBlock
{
    NSString * urlStr =[NSString stringWithFormat:@"%@?type=needs_goods",NSLocalizedString(@"BASEURL", "")];
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
                [returnList addObject:[[GoodsBean alloc] initWithDictionary:bean]];
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
