//
//  Network.m
//  instaparty
//
//  Created by Ajay Penmatcha on 7/9/15.
//  Copyright (c) 2015 Ajay Penmatcha Apps. All rights reserved.
//

#import "Network.h"
@implementation Network

+(AFHTTPSessionManager*)sharedManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:kBaseURL];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
    });
    return manager;
}

+(void)sendRequestToURL:(NSString*)url parameters:(NSDictionary*)parameters
        success:(void(^)(NSURLSessionDataTask* _Nonnull task, NSArray<NSDictionary*> * _Nonnull responseObject))success
        failure:(void(^)(NSURLSessionDataTask* _Nullable task, NSError * _Nonnull error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[Network sharedManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSArray<NSDictionary*> *  _Nonnull responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success)
            success(task, responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure)
            failure(task, error);
    }];
}

+(NSString*)getUrlForAPI:(NSString*)api {
    return [NSString stringWithFormat:@"%@://%@:%d/%@", kProtocol, kBaseURL, port, api];
}

@end
