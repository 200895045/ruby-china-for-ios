//
//  RCFirstViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCViewController.h"
#import <SSPullToRefresh.h>
#import "RCNavLeftRightButtonItem.h"

@interface RCTopicsViewController : RCViewController <UITableViewDataSource, UITableViewDelegate, SSPullToRefreshViewDelegate, SSPullToRefreshContentView> {
    NSArray *topics;
    
    SSPullToRefreshView *pullToRefreshView;
}

+ (RCTopicsViewController *) shared;


- (void) refresh;

@end
