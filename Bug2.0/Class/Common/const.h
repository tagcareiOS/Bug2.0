//
//  const.h
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#ifndef const_h
#define const_h

#pragma mark - URL
//developement
#define SERVER_URL  @"http://192.168.1.134:9999/bugreporter/"

//production
//#define SERVER_URL  @""

#pragma mark - 网络访问的返回，提交成功时

#define SERVER_FLAG_SUCCESS 1

#define SERVER_FLAG_USER_ERROR 2
#define SERVER_FLAG_USER_DEACTIVATED 3

#define REQUEST_DATA @"requestData"
#define REQUEST_CODE @"requestCode"
#define REQUEST_DICTIONARY @"requestDictionary"

//定义网络的广播请求时，使用的notification
#define NOTIFICATION_DEFAULT @"notificationDefault"

#pragma mark - 登录状态
#define LOGIN_NO 0
#define LOGIN_YES 1

#pragma mark - md5
#define SALT @"tagcare.md5@bj-china"

#pragma mark - 公用头文件

#pragma mark - requestCode
//网络访问
#define RET_INVALID_ACCESS_TOKEN 5
//登录
#define REQUEST_CODE_USER_LOGIN 0





#endif /* const_h */
