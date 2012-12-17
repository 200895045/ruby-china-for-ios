//
//  RCNewTopicViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTopicForm.h"

@interface RCNewTopicViewController : UITableViewController {
    RCTopicForm *topicForm;
}

+ (RCNewTopicViewController *) shared;

@end
