//
//  NetworkUtil.m
//  Bug
//
//  Created by Tagcare on 15/11/4.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "NetworkUtil.h"
#import "const.h"
#import "UserDefault.h"
//#import "WLYHttpRequestOperation.h"

@implementation NetworkUtil

//+(AFHTTPRequestOperationManager *)sendRequestToServer:(NSString *)api
//                                                 data:(NSMutableDictionary *)data
//                                               object:(id)object
//                                          requestCode:(NSNumber *)requestCode
//{
//
//    NSString * strUrl = [SERVER_URL stringByAppendingString:api];
//    //返回网络请求的线程
//    return [WLYHttpRequestOperation networkRequest:strUrl
//                                       dictionary:data
//                                           object:object
//                                      requestCode:requestCode];
//    
//}

#pragma mark - 请求错误
+(void)receiveNetworkErroResponse:(NSMutableDictionary *)response{
    
    //TODO:请求失败后的操作
    NSLog(@"请求失败");
    
//    int notificationFlag = 0;
//    
//    NSNumber * requestCode = [response valueForKey:REQUEST_CODE];
//    switch ([requestCode integerValue]) {
//        case REQUEST_CODE_UPDATE_NOTE:{
//            Note * note = [response valueForKey:REQUEST_DATA];
//            note.send_flag = @SEND_FAILED;
//            [NoteBL createOrUpdateNote:note];
//            [response setValue:@REQUEST_CODE_FIND_NOTES forKey:REQUEST_CODE];
//            notificationFlag = 1;
//            break;
//        }
//        case REQUEST_CODE_CREATE_TARGET:{
//            Target * target = [response valueForKey:REQUEST_DATA];
//            target.send_flag = @SEND_FAILED;
//            target.status = @TARGET_STATUS_DRAFT;
//            [target createOrUpdate];
//            [response setValue:@REQUEST_CODE_FIND_TARGETS forKey:REQUEST_CODE];
//            notificationFlag = 1;
//        }
//        case REQUEST_CODE_UPLOAD_FILE:{
//            id object = [response valueForKey:REQUEST_DATA];
//            if ([object isKindOfClass:[Note class]]) {
//                Note * note = (Note *)object;
//                note.send_flag = @SEND_FAILED;
//                [NoteBL createOrUpdateNote:note];
//                notificationFlag = 1;
//
//            }
//            break;
//        }
//
//        default:{
//            break;
//        }
//    }
//    
//    NSNumber * result = [response valueForKey:@"result"];
//    if ([result isEqualToNumber:@RET_INVALID_USER]) {
//        //set userDefault
//        UserDefault * userDefault = [[UserDefault alloc]init];
//        userDefault.isLogin = @READYGOOO_NO;
//        [userDefault update];
//        notificationFlag = 1;
//    }
//    
//    //如果有新消息，将内容封装到广播中 给ios系统发送广播
//    if (notificationFlag) {
//        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
//        [nc postNotificationName:NOTIFICATION_DEFAULT object:self userInfo:response];
//    }else{
//        NSString * message = @"";
//        switch ([result integerValue]) {
//            case RET_NO_SUCH_USER:{
//                message = NO_SUCH_USER;
//            }
//                break;
//            case RET_NO_PERMISSION_ADD_SELF:{
//                message = INVALID_ADD_SELF;
//            }
//                break;
//            case RET_NO_PERMISSION_UPDATE_SYSTEM_USER:{
//                message = INVALID_DELETE_SYSTEM_USER;
//            }
//                break;
//
//            default:{
//                message = [response valueForKey:@"result_msg"];
//                message = NETWORK_REQUEST_ERROR;
//                message = @"";
//            }
//                break;
//        }
//        if([message length] > 0){
//            [Utils alertTitle:REMINDER message:message delegate:self cancelBtn:KNOWN_TEXT otherBtnName:nil];
//        }
//    }

}



//接受来自网络的请求结果
+(void)receiveNetworkResponse:(NSMutableDictionary *)response{
    
    int notificationFlag = 0;

    if ([[response valueForKey:@"flag"] isEqual:[NSNumber numberWithInt:SERVER_FLAG_SUCCESS]]) {

        
        //according requestCode to take the next step
        NSNumber * requestCode = [response valueForKey:@"requestCode"];
        switch ([requestCode integerValue]) {
//#pragma mark - note
//            case REQUEST_CODE_UPDATE_NOTE:{
//                Note * note = [response valueForKey:REQUEST_DATA];
//                [NoteBL findNewestNoteAtServer:note.target_id];
//                break;
//            }
//            case REQUEST_CODE_FIND_NOTES:{
//                //将获得的最新note存入数据庫
//                NSMutableDictionary * noteDictionary = [response valueForKey:@"data"];
//                if ([noteDictionary count] > 0) {
//                    NSNumber * target_id = [response valueForKey:@"requestData"];
//                    [NoteBL createBatchNotesWithDictionary:noteDictionary target_id:target_id];
//                    
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_GET_NOTE_READ_STATUS:{
//                //forward the response to controller
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_NOTE_ADD_TAG:{
//                notificationFlag = 1;
//                break;
//            }
//#pragma mark - target
//            case REQUEST_CODE_FIND_MARKET_TARGET:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_CREATE_TARGET:{
//                [Target findTargetsAtServer];
//                notificationFlag = 0;
//                break;
//            }
//            case REQUEST_CODE_UPDATE_TARGET:{
//                [Target findTargetsAtServer];
//                break;
//            }
//            
//            case REQUEST_CODE_FIND_TARGETS:{
//                NSMutableDictionary * dictionary = [response valueForKey:@"data"];
//                [Target createOrUpdateBatchTargetsWithDictionary:dictionary];
//                if ([dictionary count] > 0) {
//                    notificationFlag = 1;
//                }
//                
//                //continue to find targets at server
//                if ([dictionary count] >= SERVER_REQUEST_COUNT) {
//                    [Target findTargetsAtServer];
//                }
//                break;
//            }
//            case REQUEST_CODE_TARGET_SUMMARY:
//                notificationFlag = 1;
//                break;
//            case REQUEST_CODE_TARGET_SHARE:
//                notificationFlag = 1;
//                break;
//            case REQUEST_CODE_TARGET_BUDGET_NEW_BUDGET:{
//                notificationFlag = 1;
//                //TODO:更新数据库兑现状态
//                NSDictionary * dict = response[@"requestDictionary"];
//                NSArray * noteIdArray = dict[@"note_id"];
//                NSLog(@"noteIdArray  %@",noteIdArray);
//                [NoteBL updateTotalCostNote:noteIdArray cost_status:@COST_STATUS_NEW];
//            }
//                break;
//            case REQUEST_CODE_TARGET_BUDGET_GET_BUDGET:{
//                notificationFlag = 1;
//            }
//                break;
//            case REQUEST_CODE_TARGET_BUDGET_UPDATE_BUDGET_STATUS:{
//                notificationFlag = 1;
//                
//            }
//                break;
#pragma mark - user request
//            case REQUEST_CODE_USER_REGISTER:{
//                notificationFlag = 1;
//                break;
//            }
            case REQUEST_CODE_USER_LOGIN:{
                notificationFlag = 1;
                
                break;
            }
//            case REQUEST_CODE_USER_LOGIN_THIRD:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_UPDATE_USER:{
//                UserDefault * userDefault = [response valueForKey:REQUEST_DATA];
//                [userDefault update];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_USER_GET:{
//               
//                NSMutableDictionary * helperDictionary = [response valueForKey:@"data"];
//                if (helperDictionary != nil) {
//                    UserDefault * userDefault = [[UserDefault alloc]init];
//                    if ([userDefault.user_id isEqual:[helperDictionary valueForKey:@"user_id"]]) {
//                        //save the user to default center
//                        [userDefault saveDictionaryUser:helperDictionary];
//                    }else{
//                        //save helper
//                        Helper *helper = [HelperBL transferDictionaryToHelper:helperDictionary];
//                        Helper * localHelper = [HelperBL findHelperByUser_id:helper.user_id];
//                        if (localHelper != nil) {
//                            [HelperBL saveOrUpdate:helper];
//                        }else{
//                            [response setValue:helper forKey:@"helper"];
//                        }
//                    }
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_UPLOAD_USER_PHOTO:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_USER_CONTACT_UPLOAD:{
//                [HelperBL findNewestHelpersAtServer];
//                break;
//            }
//                //target member
//            case REQUEST_CODE_UPDATE_TARGET_MEMBER_STATUS:{
//                TargetMember * targetMember = [response valueForKey:REQUEST_DATA];
//                [Target findTargetMembersAtServer:targetMember.target_id];
//                break;
//            }
//            case REQUEST_CODE_UPDATE_TARGET_MEMBER:{
//                Target * target = [response valueForKey:REQUEST_DATA];
//                [target findTargetMembersAtServer];
//                break;
//            }
//            case REQUEST_CODE_FIND_TARGET_MEMBERS:{
//                notificationFlag = 1;
//                break;
//            }
//                
//#pragma mark - helper request
//            case REQUEST_CODE_DUANG_HELPER_BY_ID:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_USER_FIND_BY_ACCOUNT:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_HELPER_FIND:{
//                //将获得的最新helpers存入数据庫
//                NSMutableDictionary * helperDictionay = [response valueForKey:@"data"];
//                if ([helperDictionay count] > 0) {
//                    [HelperBL batchSaveHelpers:helperDictionay];
//                    
//                    //continue find next newest helper if over
//                    if ([helperDictionay count] >= MAX_FOR_EACH_COUNT) {
//                        [HelperBL findNewestHelpersAtServer];
//                    }
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_GROUP_FIND:{
//                //save the new group
//                NSMutableDictionary * groupDictionary = [response valueForKey:@"data"];
//                if ([groupDictionary count] > 0) {
//                    [GroupBL saveOrUpdateGroupsDictionary:groupDictionary];
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_UPDATE_RELATIONSHIP:{
//                //save the helper relationship to db
////                [HelperBL saveOrUpdate:[response valueForKey:REQUEST_DATA]];
////                notificationFlag = 1;
//                [HelperBL findNewestHelpersAtServer];
//                break;
//            }
//                
//            case REQUEST_CODE_UPDATE_GROUP:{
//                //create or update group
//                NSDictionary * groupDic = [response valueForKey:@"data"];
//                NSArray * members = [groupDic valueForKey:@"members"];
//                if (groupDic) {
//                    Group * group = [GroupBL changeDictionaryToObject:groupDic];
//                    [GroupBL saveOrUpdateGroup:group];
//                    [GroupBL addMemberIdsOfGroup:members group:group];
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_UPDATE_GROUP_INFO:{
//                Group * group = [response valueForKey:REQUEST_DATA];
//                [GroupBL saveOrUpdateGroup:group];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_DELETE_GROUP:{
//                Group * group = [response valueForKey:REQUEST_DATA];
//                [GroupBL deleteGroupById: group];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_UPDATE_GROUP_MEMBERS:{
//                Group * group = [response valueForKey:REQUEST_DATA];
//                NSArray * members = [Tools changeStringToArray:group.members];
//                [GroupBL updateGroupMembers:members groupId:group.grp_id];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_FIND_GROUP_MEMBERS:{
//                [HelperBL addMembersToGroup:response];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_UPDATE_PUBLIC_HELPER:{
//                NSMutableDictionary * requestData = [response valueForKey:REQUEST_DICTIONARY];
//                NSNumber * status = [requestData valueForKey:@"status"];
//                UserDefault * userDefault = [[UserDefault alloc]init];
//                userDefault.status = status;
//                [userDefault update];
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_FIND_PUBLIC_HELPERS:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_ADD_HELPER_BY_ID:{
//                notificationFlag = 1;
//                break;
//            }
//#pragma mark - upload file
//            case REQUEST_CODE_UPLOAD_FILE:{
//                id object = [response valueForKey:@"object"];
//                if ([object isKindOfClass:[Note class]]) {
//                    Note * note = (Note *)object;
//                    note.file_id = [[response valueForKey:RESPONSE_DATA] valueForKey:@"file_id"];
//                    [NoteBL sendNote:note];
//                    [[NSFileManager defaultManager] removeItemAtPath:note.imageFileName error:nil];
//                }
//                break;
//            }
//#pragma mark - task
//            case REQUEST_CODE_UPDATE_TASK:{
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_FIND_TASK:{
//                //将获得的最新task存入数据庫
//                NSMutableDictionary * taskDictionary = [response valueForKey:@"data"];
//                if ([taskDictionary count] > 0) {
//                    NSNumber * target_id = [response valueForKey:@"requestData"];
//                    [TaskBL createBatchTasksWithDictionary:taskDictionary target_id:target_id];
//                    notificationFlag = 1;
//                }
//                break;
//            }
//            case REQUEST_CODE_CREATE_TASK:{
//                //forward the response to controller
//                notificationFlag = 1;
//                break;
//            }
//            case REQUEST_CODE_FIND_TASK_TEMPLATE:{
//                notificationFlag = 1;
//                break;
//            }
//                
//            case REQUEST_CODE_GET_COST_NOTE_TAG: {
//                NSArray * costNoteTag = [response valueForKey:@"data"];
//                NSDictionary * dict = [response valueForKey:@"requestDictionary"];
//                NSNumber * target_id = dict[@"target_id"];
//                [CostNoteTag saveTagDictionaryToUserDefault:costNoteTag target_id:target_id];
//                notificationFlag = 1;
//                break;
//            }
            default:{
                notificationFlag = 1;
                break;
            }
        }
    }else if ([[response valueForKey:@"result"] isEqual:[NSNumber numberWithInt:RET_INVALID_ACCESS_TOKEN]]){
        NSLog(@"get access token again");
//        [WLYHttpRequestOperation getAccessTokenAgain];
    }
    
    //如果有新消息，将内容封装到广播中 给ios系统发送广播
    if (notificationFlag) {
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_DEFAULT object:self userInfo:response];
    }
}


@end
