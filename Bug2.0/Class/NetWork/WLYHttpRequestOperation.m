//
//  WLYHttpRequestOperation.m
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "WLYHttpRequestOperation.h"
#import "UserDefault.h"
#import "NetworkUtil.h"
#import "const.h"

@implementation WLYHttpRequestOperation

+ (instancetype)sharedClient {
    static WLYHttpRequestOperation *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [WLYHttpRequestOperation manager];
        [_sharedClient setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [[_sharedClient responseSerializer] setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        
    });
    return _sharedClient;
}


//网络请求，返回网络请求的线程
+(AFHTTPRequestOperationManager *)networkRequest:(NSString*)url
                                      dictionary:(NSMutableDictionary*)data
                                          object:(id)object {
    return [self networkRequest:url dictionary:data object:object requestCode:nil];

}

//网络请求，返回网络请求的线程, 回调函数中含有requestCode
+(AFHTTPRequestOperationManager *)networkRequest:(NSString*)url
                                      dictionary:(NSMutableDictionary*)data
                                          object:(id)object
                                     requestCode:(NSNumber *)requestCode {
    WLYHttpRequestOperation * wlyHttpRequestOpertion = [WLYHttpRequestOperation sharedClient];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    return [wlyHttpRequestOpertion networkRequest:url
                                      dictionary:data
                                          object:object
                                     requestCode:requestCode
                                      parameters:parameters];
}

//get access_token
+(void)getAccessTokenAgain {
//    UserDefault * userDefault = [[UserDefault alloc]init];
//    //reset accesstoken @"default_token"
//    userDefault.access_token = @"default_token";
//    [userDefault update];
//    
//    //set prepare paramter
//    NSMutableDictionary * parameters = [WLYHttpRequestOperation getPrepareParameter];
//    [parameters removeObjectForKey:@"user_id"];
//    
//    //set data
//    NSMutableDictionary * data = [self getLoginParameters];
//    
//    //user login
//    WLYHttpRequestOperation * operation = [WLYHttpRequestOperation sharedClient];
//    
//    //set url
//    NSString * url = [SERVER_URL stringByAppendingString:API_USER_LOGIN];
//    
//    [operation networkRequest:url
//                   dictionary:data
//                       object:nil
//                  requestCode:@REQUEST_CODE_USER_LOGIN
//                   parameters:parameters];
}

//update file to server
+(AFURLSessionManager *)uploadFile:(NSData *)file
                          fileType:(NSNumber *)fileType
                          fileName:(NSString *)fileName
                     client_ref_id:(NSString *)client_ref_id
                            object:(id)object
                       requestCode:(NSNumber *)requestCode {
    WLYHttpRequestOperation * wlyHttpRequestOpertion = [WLYHttpRequestOperation sharedClient];
    return [wlyHttpRequestOpertion uploadFile:file
                                    fileType:fileType 
                                    fileName:fileName
                               client_ref_id:client_ref_id
                                      object:object
                                 requestCode:requestCode];
    
}

+(AFURLSessionManager *)uploadFile:(NSData *)file
                          fileType:(NSNumber *)fileType
                          fileName:(NSString *)fileName
                     client_ref_id:(NSString *)client_ref_id
                       requestCode:(NSNumber *)requestCode {
    return [self uploadFile:file
                   fileType:fileType
                   fileName:fileName
              client_ref_id:client_ref_id
                     object:nil
                requestCode:requestCode];
 }

+(NSMutableDictionary *)getPrepareParameter{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
//    //set timestamp
//    NSDate * nowdata = [NSDate date];
//    NSTimeInterval  record_timeInterval = [nowdata timeIntervalSince1970];
//    [parameters setValue:[NSString stringWithFormat:@"%.0lf",record_timeInterval]forKey:@"timestamp"]; //now date
//    
//    UserDefault * userDefault = [[UserDefault alloc]init];
//    //set access_token
//    [parameters setValue:userDefault.access_token forKey:@"access_token"];
//    
//    //set user_id
//    [parameters setValue:userDefault.user_id forKey:@"user_id"];
//    
//    NSString * signature = [self getSignature:userDefault.access_token];
//    
//    //set signature
//    [parameters setValue:signature forKey:@"signature"];
    
    return parameters;
}

//网络请求，返回网络请求的线程, 回调函数中含有requestCode
-(AFHTTPRequestOperationManager *)networkRequest:(NSString*)url
                                      dictionary:(NSMutableDictionary*)data
                                          object:(id)object
                                     requestCode:(NSNumber *)requestCode
                                      parameters:(NSMutableDictionary *)parameters {
    //对上传的变量进行json封装在data变量下
    if ([data count] > 0) {
        NSError * error;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
        NSString * jsonString = @"";
        if (jsonData) {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }else {
            jsonString = @"{}";
        }
        
        [parameters setValue:jsonString forKey:@"data"];
    }
    
    //输出parameters
    NSLog(@"url = %@",url);
    NSLog(@"parameter = %@",parameters);
    
    AFHTTPRequestOperationManager * httpRequestOpeartionManager = [AFHTTPRequestOperationManager manager];
    [httpRequestOpeartionManager POST:url
                           parameters:parameters
                              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                  NSMutableDictionary * response = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                                  NSLog(@"raw response = %@",response);
                                  if ([[response valueForKey:@"flag"] isEqual:[NSNumber numberWithInt:SERVER_FLAG_SUCCESS]]) {
                                      //将请求的数据封装进返回字典
                                      [response setValue:object forKey:REQUEST_DATA];
                                      [response setValue:requestCode forKey:REQUEST_CODE];
                                      [response setValue:data forKey:REQUEST_DICTIONARY];
                                      
                                      //数据返回后的操作
                                      [NetworkUtil receiveNetworkResponse:response];
                                      NSLog(@"response = %@",response);
                                  } else {
                                      NSLog(@"error response = %@",response);
                                      [NetworkUtil receiveNetworkErroResponse:response];
                                  }
                              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                                  NSLog(@"AFHttp请求失败 %@",operation);
//                                  if ([self.debugSwitch isEqualToNumber:@DEBUG_SWITCH_ON]) {
//                                      NSString * errorMessage = [url stringByAppendingString:@" 访问时发现错误"];
//                                      [Utils alertTitle:REMINDER message:errorMessage delegate:self cancelBtn:KNOWN_TEXT otherBtnName:nil];
//                                  }
                                  //封装一个网络错误字典发送给调用者
                                  NSMutableDictionary * response = [NSMutableDictionary dictionaryWithCapacity:5];
                                  [response setValue:object forKey:REQUEST_DATA];
                                  [response setValue:requestCode forKey:REQUEST_CODE];
                                  [response setValue:data forKey:REQUEST_DICTIONARY];
                                  //请求失败后的操作
                                  [NetworkUtil receiveNetworkErroResponse:response];
                              }];
    //返回网络请求的线程
    return httpRequestOpeartionManager;
    
}

#pragma mark - upload file and get file id
//upload file to server and get file id from server
-(AFURLSessionManager *)uploadFile:(NSData *)file
                          fileType:(NSNumber *)fileType
                          fileName:(NSString *)fileName
                     client_ref_id:(NSString *)client_ref_id
                            object:(id)object
                       requestCode:(NSNumber *)requestCode {
   
    NSMutableDictionary * paremeter = [WLYHttpRequestOperation getPrepareParameter];
    
    if (fileType == nil) {
        fileType = [NSNumber numberWithInt:0];
        
    }
//    [paremeter setValue:fileType forKey:@"file_type"];
    
    //set mimeType
    NSString * mimeType = [[NSString alloc] init];
    if ([fileType intValue] == 0) {
        mimeType = @"image/png";
    }
    
    //url
    NSString * url = nil;//[SERVER_URL stringByAppendingString:UPLOAD_FILE];
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:paremeter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:file name:@"file_content" fileName:fileName mimeType:mimeType];
        
    } error:nil];
    
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress * progress = nil;
    NSURLSessionUploadTask * uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [progress removeObserver:self forKeyPath:@"fractionCompleted"];
        
        if (error) {
            NSLog(@"失败%@",[NSString stringWithFormat:@"Error: %@!",error.debugDescription]);
            //封装一个网络错误字典发给调用者
            NSMutableDictionary * response = [NSMutableDictionary dictionaryWithCapacity:5];
            [response setValue:object forKey:REQUEST_DATA];
            [response setValue:requestCode forKey:REQUEST_CODE];
            
            //请求失败后的操作
            [NetworkUtil receiveNetworkErroResponse:response];
        } else {
            NSMutableDictionary * responseDictinary = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            NSNumber * result = [NSNumber numberWithInt:[[responseDictinary valueForKey:@"result"] intValue]];
            if ([result isEqualToNumber:@SERVER_FLAG_SUCCESS]) {
                [responseDictinary setValue:object forKey:@"object"];
                [responseDictinary setValue:client_ref_id forKey:@"client_ref_id"];
                [responseDictinary setValue:requestCode forKey:REQUEST_CODE];
                
                [NetworkUtil receiveNetworkResponse:responseDictinary];
                
            } else {
                NSLog(@"response = %@", responseDictinary);
            }
        }
    }];
    
    [uploadTask resume];
    
    return manager;
    
}

@end
