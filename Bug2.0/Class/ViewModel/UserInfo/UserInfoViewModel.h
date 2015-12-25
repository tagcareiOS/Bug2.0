//
//  UserInfoViewModel.h
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "BaseViewModel.h"
#import "UserInfo.h"

@interface UserInfoViewModel : BaseViewModel

//登录
- (void)login:(UserInfo *)user;

//跳转到微博详情页
//- (void)weiboDetailWithPublicModel:(UserInfo *)publicModel WithViewController:(UIViewController *)superController;

@end
