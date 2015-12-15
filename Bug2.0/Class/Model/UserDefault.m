//
//  UserDefault.m
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "UserDefault.h"
#import "const.h"
#import "Tools.h"
#import "WLYHttpRequestOperation.h"

#define USER_DEFAULT @"userDefault"
#define USER_LOGIN @"authen/mobileLogin.do"


@implementation UserDefault

#pragma mark -init object

- (NSString *)account {
    if (_account == nil) {
        _account = @"";
    }
    return _account;
}

- (NSString *)pwd {
    if (_pwd == nil) {
        _pwd = @"";
    }
    return _pwd;
}

- (NSString *)osVersion {
    if (_osVersion == nil) {
        _osVersion = @"";
    }
    return _osVersion;
}

- (NSString *)modelNumber {
    if (_modelNumber == nil) {
        _modelNumber = @"";
    }
    return _modelNumber;
}

- (NSNumber *)userid {
    if (_userid == nil) {
        _userid = @0;
    }
    return _userid;
}

- (NSString *)nickname {
    if (_nickname == nil) {
        _nickname = @"";
    }
    return _nickname;
}

- (NSString *)realname {
    if (_realname == nil) {
        _realname = @"";
    }
    return _realname;
}

- (NSString *)deptname {
    if (_deptname == nil) {
        _deptname = @"";
    }
    return _deptname;
}

- (NSString *)rolename {
    if (_rolename == nil) {
        _rolename = @"";
    }
    return _rolename;
}

-(NSNumber *)isLogin{
    if (_isLogin == nil) {
        _isLogin = @0;
    }
    return _isLogin;
}

-(NSMutableDictionary *)dictionaryObject {
    NSMutableDictionary * userDefaultDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [userDefaultDictionary setObject:self.nickname forKey:@"nickname"];
    [userDefaultDictionary setObject:self.realname forKey:@"realname"];
    [userDefaultDictionary setObject:self.deptname forKey:@"deptname"];
    [userDefaultDictionary setObject:self.rolename forKey:@"rolename"];
    [userDefaultDictionary setObject:self.isLogin forKey:@"isLogin"];
    [userDefaultDictionary setObject:self.pwd forKey:@"pwd"];
    [userDefaultDictionary setObject:self.account forKey:@"account"];
    [userDefaultDictionary setObject:self.osVersion forKey:@"osVersion"];
    [userDefaultDictionary setObject:self.modelNumber forKey:@"modelNumber"];
    [userDefaultDictionary setObject:self.userid forKey:@"userid"];

    return userDefaultDictionary;
}

-(AFHTTPRequestOperationManager *)login{
    NSString * strUrl = [SERVER_URL stringByAppendingString:USER_LOGIN];
    
    NSMutableDictionary * data = [self loginDictionary];
    
    
    
    
    //返回网络请求的线程
    return [WLYHttpRequestOperation networkRequest:strUrl
                                       dictionary:data
                                           object:self
                                      requestCode:[NSNumber numberWithInt:REQUEST_CODE_USER_LOGIN]];
    
}

- (NSMutableDictionary *)loginDictionary {
    NSMutableDictionary * userDefaultDictionary = [NSMutableDictionary dictionaryWithCapacity:5];

    [userDefaultDictionary setObject:self.account forKey:@"account"];
    
    NSString * smd5 =[self.pwd stringByAppendingString:SALT];
    NSString * strmd5 = [Tools md5:smd5];
    [userDefaultDictionary setObject:strmd5 forKey:@"pwd"];
    
    [userDefaultDictionary setObject:self.osVersion forKey:@"osVersion"];
    
    [userDefaultDictionary setObject:self.modelNumber forKey:@"modelNumber"];
    
    return userDefaultDictionary;


}

- (void)update {
    
    //save user to NSuserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:[self dictionaryObject] forKey:USER_DEFAULT];
}

#pragma mark - 修改用户信息
-(void)saveDictionaryUser: (NSMutableDictionary *)userDictionary{
    [self setValuesForKeysWithDictionary:userDictionary];
    [self update];
}

@end
