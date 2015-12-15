//
//  BaseViewController.m
//  Bug
//
//  Created by Tagcare on 15/10/20.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "BaseViewController.h"
#import "const.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //添加通知
    [self addObserver];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    //注销通知
    [self removeObserver];
}

-(void)addObserver{
    //消息中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleNetworkResponse:)
               name:NOTIFICATION_DEFAULT
             object:nil];
    
//    // 推送
//    [nc addObserver:self selector:@selector(handlePushMessage:)
//               name:NOTIFICATION_PUSH_MSG
//             object:nil];
//    
//    // 设置为活跃通知
//    [nc addObserver:self selector:@selector(refreshData)
//               name:UIApplicationDidBecomeActiveNotification
//             object:nil];
//    //关闭应用
//    [nc addObserver:self selector:@selector(closeApp)
//               name:UIApplicationWillResignActiveNotification
//             object:nil];
}

-(void)removeObserver{
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(void)handleNetworkResponse:(NSNotification *)notification{
    NSNumber * result = [[notification userInfo] valueForKey:@"flag"];
    NSLog(@"requestCode %@",result);
    
//    if ([result isEqualToNumber:@RET_INVALID_USER]) {
//        [self skipToLogin];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
