//
//  RCTopicViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTopicViewController.h"
#import "RCTopicTableViewCell.h"
#import "RCAll.h"
#import <MBProgressHUD.h>
#import "RCNavigationBar.h"
#import "NSDate+TimeAgo.h"

#define kTopicDetailFileName @"topic_detail.html"

static RCTopicViewController *sharedInstance;

@implementation RCTopicViewController

@synthesize topic;

+ (RCTopicViewController *) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RCTopicViewController"];
    }
    
    return sharedInstance;
}

- (void)setTopic:(RCTopic *) aTopic {
    topic = aTopic;
    [self performSelectorInBackground:@selector(loadRemoteInfo:) withObject:aTopic];
}

- (void) loadRemoteInfo:(RCTopic *) aTopic {
    [hud show:YES];
    [self setupBlankWebView];
    [RCTopic findById:aTopic.ID async:^(id object, NSError *error) {
        if (!error) {
            topic = object;
            [self setupWebView];
            [hud hide:YES];
        }
    }];   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"载入中";
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    [navBar.backItem.backBarButtonItem setImage:[UIImage imageNamed:@"nav_back_icon"]];
    [navBar.backItem.backBarButtonItem setStyle:UIBarButtonItemStyleDone];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.bounces = NO;
    webView.scrollView.delegate = self;
    
    // MARK: 手势
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [webView addGestureRecognizer:recognizerRight];
}


#pragma mark - WebView
- (void) setupBlankWebView {
    NSString *html = @"";
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:html baseURL:baseURL];
}

- (void) setupWebView {
    NSString *html = [self readTemplate:@"topic_detail"];
    NSString *repliesTemplate = [self readTemplate:@"_replies"];
    NSString *noRepliesTemplate = [self readTemplate:@"_no_replies"];
    NSString *_replyTemplate = [self readTemplate:@"_reply"];
    NSString *lastReplyInfo = [self readTemplate:@"_last_reply_info"];
    
    html = [self replaceHtml:html forKey:@"bundle_path" value:[[NSBundle mainBundle] resourcePath]];
    html = [self replaceHtml:html forKey:@"title" value:topic.title];
    html = [self replaceHtml:html forKey:@"body_html" value:topic.bodyHtml];
    html = [self replaceHtml:html forKey:@"user_login" value:topic.user.login];
    html = [self replaceHtml:html forKey:@"user_avatar_url" value:topic.user.avatarUrl];
    html = [self replaceHtml:html forKey:@"node_id" value:topic.nodeId];
    html = [self replaceHtml:html forKey:@"node_name" value:topic.nodeName];
    if (topic.lastReplyUserLogin) {
        lastReplyInfo = [self replaceHtml:lastReplyInfo forKey:@"last_reply_user_login" value:topic.lastReplyUserLogin];
        lastReplyInfo = [self replaceHtml:lastReplyInfo forKey:@"replied_at" value:[topic.repliedAt timeAgo]];
    }
    else {
        lastReplyInfo = @"";
    }
    html = [self replaceHtml:html forKey:@"_last_reply_info" value:lastReplyInfo];
    html = [self replaceHtml:html forKey:@"created_at" value:[topic.createdAt timeAgo]];
    html = [self replaceHtml:html forKey:@"hits" value:topic.hits];
    html = [self replaceHtml:html forKey:@"replies_count" value:topic.repliesCount];
    
    NSMutableArray *replies = [NSMutableArray arrayWithCapacity:0];
    if (topic.replies.count > 0) {
        for (int i = 0; i < topic.replies.count; i ++) {
            RCReply *reply = [topic.replies objectAtIndex:i];
            NSString *replyHtml = [_replyTemplate copy];
            
            NSNumber *floor = [NSNumber numberWithInt:(i + 1)];
            
            replyHtml = [self replaceHtml:replyHtml forKey:@"floor" value:floor];
            replyHtml = [self replaceHtml:replyHtml forKey:@"reply.id" value:[NSNumber numberWithInt:reply.ID]];
            replyHtml = [self replaceHtml:replyHtml forKey:@"reply.user_login" value:reply.user.login];
            replyHtml = [self replaceHtml:replyHtml forKey:@"reply.user_avatar_url" value:reply.user.avatarUrl];
            replyHtml = [self replaceHtml:replyHtml forKey:@"reply.created_at" value:[reply.createdAt timeAgo]];
            replyHtml = [self replaceHtml:replyHtml forKey:@"reply.body_html" value:reply.bodyHtml];
            
            [replies addObject:replyHtml];
        }
        
        repliesTemplate = [self replaceHtml:repliesTemplate forKey:@"replies_collection" value:[replies componentsJoinedByString:@"\n"]];
        html = [self replaceHtml:html forKey:@"_replies" value:repliesTemplate];
    }
    else {
        html = [self replaceHtml:html forKey:@"_replies" value:noRepliesTemplate];
    }
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:html baseURL:baseURL];
}

- (NSString *) readTemplate: (NSString *)fileName {
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
}

- (NSString *) replaceHtml:(NSString *)html forKey:(NSString *)key value:(id)value {
    if (!value) {
        return html;
    }
    
    NSString *stringValue = @"";
    if ([value isKindOfClass:[NSString class]]) {
        stringValue = value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        stringValue = [value stringValue];
    }
    else if ([value isKindOfClass:[NSDate class]]) {
        stringValue = [value timeAgo];
    }

    
    key = [NSString stringWithFormat:@"{{%@}}",key];
    html = [html stringByReplacingOccurrencesOfString:key withString:stringValue];
    return html;
}

#pragma mark - 手势
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer  {
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            break;
        case UISwipeGestureRecognizerDirectionUp:
            break;
        default:
            break;
    }

}

@end
