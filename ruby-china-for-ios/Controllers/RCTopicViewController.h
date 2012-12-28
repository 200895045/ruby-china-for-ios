//
//  RCTopicViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCViewController.h"

@class RCTopic;

@interface RCTopicViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>  {
    RCTopic *topic;
    IBOutlet UIWebView *webView;
}

+ (RCTopicViewController *) shared;

@property (nonatomic, strong) RCTopic *topic;

- (void) appendReply: (RCReply *)reply;


- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)replyButtonClick:(id)sender;
@end
