//
//  WLYHttpRequestOperation.h
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface WLYHttpRequestOperation : AFHTTPRequestOperationManager


+ (instancetype)sharedClient;

//网络请求，返回网络请求的线程
+(AFHTTPRequestOperationManager *)networkRequest:(NSString*)url dictionary:(NSMutableDictionary*)data object:(id)object;

//网络请求，返回网络请求的线程, 回调函数中含有requestCode
+(AFHTTPRequestOperationManager *)networkRequest:(NSString*)url
                                      dictionary:(NSMutableDictionary*)data
                                          object:(id)object
                                     requestCode:(NSNumber *)requestCode;

//get access_token
+(void)getAccessTokenAgain;

//update file to server
+(AFURLSessionManager *)uploadFile:(NSData *)file
                          fileType:(NSNumber *)fileType
                          fileName:(NSString *)fileName
                     client_ref_id:(NSString *)client_ref_id
                            object:(id)object
                       requestCode:(NSNumber *)requestCode;

+(AFURLSessionManager *)uploadFile:(NSData *)file
                          fileType:(NSNumber *)fileType
                          fileName:(NSString *)fileName
                     client_ref_id:(NSString *)client_ref_id
                       requestCode:(NSNumber *)requestCode;

@end
