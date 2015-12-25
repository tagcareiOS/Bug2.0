//
//  WLYHTTPRequestManager.h
//  Bug2.0
//
//  Created by Tagcare on 15/12/22.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WLYHTTPRequestManager : AFHTTPSessionManager

+ (instancetype)sharedClient;


@end
