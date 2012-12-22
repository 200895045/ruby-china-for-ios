//
//  RCLoginViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLoginForm.h"

@class MBProgressHUD;

@interface RCLoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    RCLoginForm *loginForm;
    MBProgressHUD *hud;
}

@property (nonatomic, strong) UITableView *tableView;

@end
