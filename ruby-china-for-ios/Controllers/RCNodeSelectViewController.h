//
//  RCNodeSelectViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCNode;

@interface RCNodeSelectViewController : UITableViewController {
    NSArray *nodes;
}

@property (nonatomic,strong) RCNode *selectedNode;

+ (RCNodeSelectViewController *) shared;

@end
