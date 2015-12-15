//
//  NetworkUtil.h
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUtil : NSObject

//接受来自网络的请求结果
+(void)receiveNetworkResponse:(NSMutableDictionary *)response;

+(void)receiveNetworkErroResponse:(NSMutableDictionary *)response;

@end
