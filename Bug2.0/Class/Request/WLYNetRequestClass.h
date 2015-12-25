//
//  WLYNetRequestClass.h
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLYNetRequestClass : NSObject

#pragma 监测网络的可链接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma POST请求
+ (void)netRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ReturnValueBlock) block
                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock;

#pragma GET请求
+ (void)netRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock;

@end
