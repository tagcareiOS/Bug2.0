//
//  BugTabBarController.m
//  Bug2.0
//
//  Created by Tagcare on 15/12/21.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import "BugTabBarController.h"
#import "FvtViewController.h"
#import "SitViewController.h"
#import "XtsViewController.h"

@interface BugTabBarController ()

@end

@implementation BugTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SitViewController * sitVC = [[SitViewController alloc] initWithNibName:@"SitViewController" bundle:nil];
    UINavigationController * sitNC = [[UINavigationController alloc] initWithRootViewController:sitVC];
    sitVC.title = @"Sit";
    
    FvtViewController * fvtVC = [[FvtViewController alloc] initWithNibName:@"FvtViewController" bundle:nil];
    UINavigationController * fvtNC = [[UINavigationController alloc] initWithRootViewController:fvtVC];
    fvtVC.title = @"Fvt";
    
    XtsViewController * xtsVC = [[XtsViewController alloc] initWithNibName:@"XtsViewController" bundle:nil];
    UINavigationController * xtsNC = [[UINavigationController alloc] initWithRootViewController:xtsVC];
    xtsVC.title = @"Xts";
    
    self.viewControllers = @[sitNC,fvtNC,xtsNC];
    
    // Do any additional setup after loading the view.
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
