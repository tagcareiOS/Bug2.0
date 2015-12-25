//
//  UserInfo.m
//  Bug2.0
//
//  Created by Tagcare on 15/12/22.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(NSNumber *)isLogin{
    if (_isLogin == nil) {
        _isLogin = @0;
    }
    return _isLogin;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

//保存用户
+(void)userAccount:(NSString *)account pwd:(NSString *)pwd osVersion:(NSString *)osVersion modelNumber:(NSString *)modelNumber nickname:(NSString *)nickname realname:(NSString *)realname deptname:(NSString *)deptname rolename:(NSString *)rolename userid:(NSNumber *)userid isLogin:(NSNumber *)isLogin {

    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * filePath = [documentPath stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dicfilePath = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //生成唯一字符串
//    CFUUIDRef cfuuid =CFUUIDCreate(kCFAllocatorDefault);
//    NSString *cfuuidString =(NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    
    NSMutableDictionary * dataDic =[NSMutableDictionary dictionaryWithCapacity:30];
    
    [dataDic setValue:account forKey:@"account"];
    [dataDic setValue:pwd forKey:@"pwd"];
    [dataDic setValue:osVersion forKey:@"osVersion"];
    [dataDic setValue:modelNumber forKey:@"modelNumber"];
    [dataDic setValue:nickname forKey:@"nickname"];
    [dataDic setValue:realname forKey:@"realname"];
    [dataDic setValue:deptname forKey:@"deptname"];
    [dataDic setValue:rolename forKey:@"rolename"];
    [dataDic setValue:userid forKey:@"userid"];
    [dataDic setValue:isLogin forKey:@"isLogin"];
    
    NSMutableArray * dirArray = dicfilePath[@"userInfo"];
    
    if (dirArray.count == 0) {
        dirArray = [NSMutableArray arrayWithCapacity:40];
        [dirArray addObject:dataDic];
        
    }else{
        [dirArray insertObject:dataDic atIndex:0];
    }
    
    NSDictionary * dic = @{
                           @"userInfo":dirArray
                           
                           };
    [dic writeToFile:filePath atomically:YES];
    
}

//读取用户信息
+ (instancetype)userInformation {
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * filePath = [documentPath stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSError * error;
    
    UserInfo * model = [MTLJSONAdapter modelOfClass:[UserInfo class] fromJSONDictionary:dic error:&error];
    return model;
    
}

@end
