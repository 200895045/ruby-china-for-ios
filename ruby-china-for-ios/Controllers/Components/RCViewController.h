//
//  RCViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCViewController : UIViewController {
    IBOutlet UITableView *tableView;
}

@property (nonatomic, readonly) UIViewController *rootViewController;


@end
