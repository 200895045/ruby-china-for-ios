//
//  RCReplyViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCReplyViewController : UIViewController {
    IBOutlet UITextView *bodyTextView;
    
    RCTopic *topic;
    
}

+ (RCReplyViewController *) shared;

- (void) setTopic: (RCTopic *) aTopic;

@end
