//
//  BaseViewController.h
//  Bug
//
//  Created by Tagcare on 15/10/20.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)handleNetworkResponse:(NSNotification *)notification;

-(void)addObserver;

-(void)removeObserver;

@end
