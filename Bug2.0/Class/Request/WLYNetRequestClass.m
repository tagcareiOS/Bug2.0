//
//  WLYNetRequestClass.m
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "WLYNetRequestClass.h"

@implementation WLYNetRequestClass

#pragma 监测网络的可链接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPSessionManager * session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = session.operationQueue;
    
    [session.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [session.reachabilityManager startMonitoring];
    
    return netState;
}


/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic
 ******************************/

#pragma --mark GET请求方式
+ (void)netRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock
{
    
    NSURL * URL = [NSURL URLWithString:requestURLString];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    [session GET:URL.absoluteString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DDLog(@"%@", dic);
        
        block(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock();

    }];
    
    session.responseSerializer =[AFHTTPResponseSerializer serializer];

}

#pragma --mark POST请求方式

+ (void)netRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ReturnValueBlock) block
                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    NSURL * URL = [NSURL URLWithString:requestURLString];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    [session POST:URL.absoluteString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        DDLog(@"%@", dic);
        
        block(dic);
        /***************************************
         在这做判断如果有dic里有errorCode
         调用errorBlock(dic)
         没有errorCode则调用block(dic
         ******************************/
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock();
    }];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
}


@end
