//
//  RCReplyViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCReplyViewController.h"

@interface RCReplyViewController ()

@end

@implementation RCReplyViewController

static RCReplyViewController *_shared;
+ (RCReplyViewController *) shared {
    if (!_shared) {
        _shared =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RCReplyViewController"];
    }
    return _shared;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"回帖";

    self.navigationController.navigationBar.topItem.leftBarButtonItem.title = @"取消";
    self.navigationController.navigationBar.topItem.rightBarButtonItem.title = @"回复";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTopic: (RCTopic *) aTopic {
    topic = aTopic;
}

@end
