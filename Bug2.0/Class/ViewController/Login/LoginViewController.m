//
//  LoginViewController.m
//  Bug
//
//  Created by Tagcare on 15/11/5.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "LoginViewController.h"
#import "BugTabBarController.h"
#import "UserInfoViewModel.h"
#import "UserInfo.h"
#import "const.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFeld;
@property (nonatomic, strong) UserInfo * user;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [[UserInfo alloc] init];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickLoginButtonAction:(id)sender {
    
    BugTabBarController * bugTab = [[BugTabBarController alloc] init];
    [self presentViewController:bugTab animated:YES completion:nil];

    
    [self getIPoneInformation];
    self.user.pwd = self.passwordFeld.text;
    self.user.account = self.nameField.text;
    
    
    
    UserInfoViewModel * userInfoVM = [[UserInfoViewModel alloc] init];
    [userInfoVM setBlockWithReturnBlock:^(id returnValue) {
        
        DDLog(@"%@",returnValue);
        
    } WithErrorBlock:^(id errorCode) {
        
        
    } WithFailureBlock:^{
        
        
    }];
    
    [userInfoVM login:self.user];

   
//    [self.userDefault login];
    
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:@selector(handleNetworkResponse:)
//               name:NOTIFICATION_DEFAULT
//             object:nil];
    
}

- (void)getIPoneInformation {
    UIDevice * device = [UIDevice currentDevice];
    //手机系统版本
    NSString* systemVersion = [device systemVersion];
    //设备名称
    NSString* systemName = [device systemName];
    
    self.user.osVersion = systemVersion;
    self.user.modelNumber = systemName;

}

//-(void)handleNetworkResponse:(NSNotification *)notification{
//  
//    [super handleNetworkResponse:notification];
//    
//    NSDictionary * dict = [notification userInfo];
//    
//    NSNumber * requestCode = [dict valueForKey:@"requestCode"];
//    NSLog(@"requestCode %@",requestCode);
//
//    
//    if ([requestCode isEqualToValue:@REQUEST_CODE_USER_LOGIN]) {
//        
//        //set user default device_id
//        NSMutableDictionary * data = [dict valueForKey:@"data"];
//        UserDefault * userDefault = [[UserDefault alloc]init];
//        userDefault.isLogin = @LOGIN_NO;
//        [userDefault saveDictionaryUser:data];
//        [self dismissViewControllerAnimated:YES completion:nil];
//
//
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
