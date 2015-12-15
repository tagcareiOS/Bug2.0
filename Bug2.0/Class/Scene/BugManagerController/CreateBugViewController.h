//
//  CreateBugViewController.h
//  Bug
//
//  Created by Tagcare on 15/10/21.
//  Copyright © 2015年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EBPhotoPagesDataSource.h"
#import "EBPhotoPagesDelegate.h"

@interface CreateBugViewController : BaseViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EBPhotoPagesDataSource, EBPhotoPagesDelegate>

@end
