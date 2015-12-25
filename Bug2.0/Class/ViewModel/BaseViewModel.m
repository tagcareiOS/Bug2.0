//
//  BaseViewModel.m
//  Bug2.0
//
//  Created by Tagcare on 15/12/23.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

#pragma 获取网络可到达状态
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock WithURlStr: (NSString *) strURl;
{
    BOOL netState = [WLYNetRequestClass netWorkReachabilityWithURLString:strURl];
    netConnectBlock(netState);
}

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

@end
