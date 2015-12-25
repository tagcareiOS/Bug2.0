//
//  UserInfo.h
//  Bug2.0
//
//  Created by Tagcare on 15/12/22.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * account;  //账号
@property (nonatomic, strong) NSString * pwd;      //密码
@property (nonatomic, strong) NSString * osVersion;//手机系统版本
@property (nonatomic, strong) NSString * modelNumber;//机型
@property (nonatomic, strong) NSString * nickname; //昵称
@property (nonatomic, strong) NSString * realname; //真实姓名
@property (nonatomic, strong) NSString * deptname; //部门名称
@property (nonatomic, strong) NSString * rolename; //角色名称
@property (nonatomic, strong) NSNumber * userid;   //用户id

@property (nonatomic, retain) NSNumber * isLogin;  //登录状态 yes is 1, no is 0

+(void)userAccount:(NSString *)account pwd:(NSString *)pwd osVersion:(NSString *)osVersion modelNumber:(NSString *)modelNumber nickname:(NSString *)nickname realname:(NSString *)realname deptname:(NSString *)deptname rolename:(NSString *)rolename userid:(NSNumber *)userid isLogin:(NSNumber *)isLogin;
+ (instancetype)userInformation;

@end
