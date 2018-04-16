//
//  Network.h
//  instaparty
//
//  Created by Ajay Penmatcha on 7/9/15.
//  Copyright (c) 2015 Ajay Penmatcha Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *kBaseURL = @"34.214.169.181";
static NSString *kProtocol = @"http";
static unsigned int port = 5000;

static NSString *kLoginApi = @"login";
NS_ASSUME_NONNULL_END

@interface Network : NSObject

+(void)sendRequestToURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters
                success:(void(^_Nullable)(NSURLSessionDataTask* _Nonnull task, NSArray<NSDictionary*> * _Nonnull responseObject))success
                failure:(void(^_Nullable)(NSURLSessionDataTask* _Nullable task, NSError * _Nonnull error))failure;

+(NSString*)getUrlForAPI:(NSString*)api;

@end
