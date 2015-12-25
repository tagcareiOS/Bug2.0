
//  UserInfoViewModel.m
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "UserInfoViewModel.h"

@implementation UserInfoViewModel

- (void)login:(UserInfo *)user {
    
    NSDictionary * parameter = @{@"account":user.account,
                                 @"pwd":[Tools md5:[user.pwd stringByAppendingString:SALT]],
                                 @"osVersion":user.osVersion,
                                 @"modelNumber":user.modelNumber
                                 };

    /**
     *  构建上传数据
     *
     *  @param NSDictionary 上传的数据应从界面上获取，也就是用户填入的信息。密码需要md5加密。
     *
     *  @return parameter
     */
    
    [WLYNetRequestClass netRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@authen/mobileLogin.do",SERVER_URL] WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        //成功获取数据后的操作
        DDLog(@"登录");
    } WithErrorCodeBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
}

////获取公共微博
//-(void) fetchPublicWeiBo
//{
//    NSDictionary *parameter = @{TOKEN: ACCESSTOKEN,
//                                COUNT: @"100"
//                                };
//    [WLYNetRequestClass NetRequestGETWithRequestURL:REQUESTPUBLICURL WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
//        
//        DDLog(@"%@", returnValue);
//        [self fetchValueSuccessWithDic:returnValue];
//        
//    } WithErrorCodeBlock:^(id errorCode) {
//        DDLog(@"%@", errorCode);
//        [self errorCodeWithDic:errorCode];
//        
//    } WithFailureBlock:^{
//        [self netFailure];
//        DDLog(@"网络异常");
//        
//    }];
//    
//}



#pragma 获取到正确的数据，对正确的数据进行处理
//-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue
//{
//    //对从后台获取的数据进行处理，然后传给ViewController层进行显示
//    
//    NSArray *statuses = returnValue[STATUSES];
//    NSMutableArray *publicModelArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
//    
//    for (int i = 0; i < statuses.count; i ++) {
//        PublicModel *publicModel = [[PublicModel alloc] init];
//        
//        //设置时间
//        NSDateFormatter *iosDateFormater=[[NSDateFormatter alloc]init];
//        iosDateFormater.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
//        
//        //必须设置，否则无法解析
//        iosDateFormater.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//        NSDate *date=[iosDateFormater dateFromString:statuses[i][CREATETIME]];
//        
//        //目的格式
//        NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
//        [resultFormatter setDateFormat:@"MM月dd日 HH:mm"];
//        
//        publicModel.date = [resultFormatter stringFromDate:date];
//        publicModel.userName = statuses[i][USER][USERNAME];
//        publicModel.text = statuses[i][WEIBOTEXT];
//        publicModel.imageUrl = [NSURL URLWithString:statuses[i][USER][HEADIMAGEURL]];
//        publicModel.userId = statuses[i][USER][UID];
//        publicModel.weiboId = statuses[i][WEIBOID];
//        
//        [publicModelArray addObject:publicModel];
//        
//    }
//    
//    self.returnBlock(publicModelArray);
//}

//#pragma 对ErrorCode进行处理
//-(void) errorCodeWithDic: (NSDictionary *) errorDic
//{
//    self.errorBlock(errorDic);
//}
//
//#pragma 对网路异常进行处理
//-(void) netFailure
//{
//    self.failureBlock();
//}
//
//
//#pragma 跳转到详情页面，如需网路请求的，可在此方法中添加相应的网络请求
//-(void) weiboDetailWithPublicModel: (PublicModel *) publicModel WithViewController:(UIViewController *)superController
//{
//    DDLog(@"%@,%@,%@",publicModel.userId,publicModel.weiboId,publicModel.text);
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    PublicDetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"PublicDetailViewController"];
//    detailController.publicModel = publicModel;
//    [superController.navigationController pushViewController:detailController animated:YES];
//    
//}



@end
