//
//  RCViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCViewController.h"
#import "RCAppDelegate.h"

@implementation RCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIViewController *) rootViewController {
    RCAppDelegate *appDelegate = (RCAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.window.rootViewController;
}

@end
