//
//  WebServiceBaseClass.m
//
//  Created by Elagoon.
//  Copyright © 2017 Elagoon. All rights reserved.
//

#import "WebServiceBaseClass.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"


@implementation WebServiceBaseClass


+(void)CallGet:(NSString *)serviceUrl Param:(NSDictionary *)params Completion:(void(^)(BOOL isSucceed, NSDictionary *response))completion {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 7.0;
    [manager GET:serviceUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completion(NO,nil);
        
    }];
    
}


+(void)CallPost:(NSString *)serviceUrl Param:(NSDictionary *)params Completion:(void(^)(BOOL isSucceed, NSDictionary *response))completion {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.0;
    [manager POST:serviceUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completion(NO,nil);
        
    }];
    
}



@end
