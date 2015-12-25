//
//  Config.h
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#ifndef Config_h
#define Config_h

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#pragma mark - 接口
#define SERVER_URL  @"http://192.168.1.134:9999/bugreporter/"

#pragma mark - md5
#define SALT @"tagcare.md5@bj-china"

#pragma mark - 登录状态
#define LOGIN_NO 0
#define LOGIN_YES 1

//accessToken
#define ACCESSTOKEN @"你自己的access_token"

#define SOURCE @"source"
#define TOKEN @"access_token"
#define COUNT @"count"

#define STATUSES @"statuses"
#define CREATETIME @"created_at"
#define WEIBOID @"id"
#define WEIBOTEXT @"text"
#define USER @"user"
#define UID @"id"
#define HEADIMAGEURL @"profile_image_url"
#define USERNAME @"screen_name"

#endif /* Config_h */
