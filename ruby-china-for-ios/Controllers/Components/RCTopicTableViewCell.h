//
//  RCTopicCell.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCTopic;
@class SSBadgeView;

@interface RCTopicTableViewCell : UITableViewCell <UITextFieldDelegate> {
    UIImageView *avatarImageView;
    UILabel *titleLabel;
    UILabel *userLabel;
    UILabel *nodeLabel;
    UILabel *timeLabel;
    UILabel *counterLabel;
    UILabel *bodyLabel;
    SSBadgeView *badgeView;

    RCTopic *topic;
}

- (id) initWithTopic: (RCTopic *) aTopic;
- (id) initWithTopic: (RCTopic *) aTopic forDetail:(BOOL)isForDetail;

@end
