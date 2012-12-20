//
//  RCTopicCell.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTopicTableViewCell.h"
#import "RCTopic.h"
#import "RCUser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SSToolkit/SSLabel.h>
#import <SSToolkit/SSBadgeView.h>
#import "NSDate+TimeAgo.h"
#import <QuartzCore/QuartzCore.h>

#define kTitleTextColor [UIColor colorWithRed:0.2824 green:0.2667 blue:0.2706 alpha:1.0000]
#define kTitleTextHighlightColor [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0000]
#define kTitleFontSize 14

#define kSubTextColor [UIColor colorWithRed:0.5765 green:0.5686 blue:0.5725 alpha:1.0000]
#define kSubTextHighlightColor [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0000]
#define kSubTextFontSize 12

#define kBadgeColor [UIColor colorWithRed:0.4419 green:0.5471 blue:0.7736 alpha:0.8]
#define kBadgeWidth 40

#define kBackgroundHighlightColor [UIColor colorWithRed:0.9686 green:0.9490 blue:0.9882 alpha:1.0000]
#define kBorderTopImage [UIImage imageNamed:@"tableview_cell_border_top.png"]
#define kBorderBottomImage [UIImage imageNamed:@"tableview_cell_border_bottom.png"]
#define kBackgroundImage [UIImage imageNamed:@"tableview_cell_bg.png"]
#define kBackgroundHighlightImage [UIImage imageNamed:@"tableview_cell_bg_selected.png"]

@implementation RCTopicTableViewCell

- (id) initWithTopic: (RCTopic *) aTopic {
    return [self initWithTopic:aTopic forDetail:NO];
}

- (id) initWithTopic: (RCTopic *) aTopic forDetail:(BOOL)isForDetail {
    self = [super initWithStyle:UITableViewCellSelectionStyleGray reuseIdentifier:[NSString stringWithFormat:@"topic-%d", [aTopic.ID intValue]]];

    topic = aTopic;
    
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:kBackgroundHighlightImage];
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
        [avatarImageView setImageWithURL:[NSURL URLWithString:topic.user.avatarUrl] placeholderImage:[RCUser defaultAvatarImage]];
        [self addSubview:avatarImageView];
        
        
        
        // User nick
        int userNickHeight = 14;
        CGSize userNickSize = [topic.user.login sizeWithFont:[UIFont systemFontOfSize:kSubTextFontSize]
                                           constrainedToSize:CGSizeMake(MAXFLOAT, userNickHeight)];
        userLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.frame.size.width + avatarImageView.frame.origin.x + 7, avatarImageView.frame.origin.y - 1, MAX(80,userNickSize.width), userNickHeight)];
        userLabel.text = topic.user.login;
        userLabel.font = [UIFont systemFontOfSize:kSubTextFontSize];
        userLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        userLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [userLabel sizeToFit];
        [self addSubview:userLabel];
        
        
        // Node
        CGSize nodeSize = [topic.nodeName sizeWithFont:[UIFont systemFontOfSize:kSubTextFontSize]
                                           constrainedToSize:CGSizeMake(MAXFLOAT, userNickHeight)];

        nodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(userLabel.frame.origin.x + userLabel.frame.size.width + 6,
                                                              userLabel.frame.origin.y, MAX(100,nodeSize.width), 14)];
        nodeLabel.text = topic.nodeName;
        nodeLabel.font = [UIFont systemFontOfSize:kSubTextFontSize];
        nodeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        nodeLabel.shadowColor = [UIColor whiteColor];
        nodeLabel.shadowOffset = CGSizeMake(0, 1);
        nodeLabel.layer.cornerRadius = 5;
        nodeLabel.layer.shouldRasterize = YES;
        nodeLabel.textAlignment = NSTextAlignmentCenter;
        nodeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.04];
        nodeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [nodeLabel sizeToFit];
        CGRect nodeFrame = nodeLabel.frame;
        nodeFrame.size.width += 6;
        nodeLabel.frame = nodeFrame;
        [self addSubview:nodeLabel];
        
        // TimeAgo
        NSString *timeAgoText = [topic.repliedAt shortTimeAgo];
        UIFont *timeAgoFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:11];
        CGSize timeSize = [timeAgoText sizeWithFont:timeAgoFont
                                     constrainedToSize:CGSizeMake(MAXFLOAT, userNickHeight)];

        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(nodeLabel.frame.origin.x + nodeLabel.frame.size.width + 6,
                                                              avatarImageView.frame.origin.y + 1,
                                                              MAX(65,timeSize.width),
                                                              18)];
        timeLabel.text = timeAgoText;
        timeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
        timeLabel.font = timeAgoFont;
        [timeLabel sizeToFit];
        [self.contentView addSubview:timeLabel];        
        
        
        int titleWidth = self.frame.size.width - avatarImageView.frame.size.width - 30 - kBadgeWidth;
        CGSize titleSize = [topic.title sizeWithFont:[UIFont systemFontOfSize:kTitleFontSize]
                                   constrainedToSize:CGSizeMake(titleWidth, MAXFLOAT)
                                       lineBreakMode:NSLineBreakByCharWrapping];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.frame.size.width + avatarImageView.frame.origin.x + 7, 26, titleWidth, MAX(18, MIN(36, titleSize.height)))];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 3;
        [titleLabel setText:topic.title];
        [titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
        [titleLabel setTextColor:kTitleTextColor];
        [titleLabel setHighlightedTextColor:kTitleTextHighlightColor];
        [self.contentView addSubview:titleLabel];
        
        
        badgeView = [[SSBadgeView alloc] initWithFrame:CGRectMake(self.frame.size.width - kBadgeWidth - 10, 26, kBadgeWidth, 16)];
        badgeView.textLabel.text = [NSString stringWithFormat:@"%d",topic.repliesCount.intValue];
        badgeView.backgroundColor = [UIColor clearColor];
        badgeView.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        badgeView.cornerRadius = 8;
        badgeView.badgeColor = kBadgeColor;
        badgeView.highlightedBadgeColor = kBadgeColor;
        badgeView.textLabel.highlightedTextColor = [UIColor whiteColor];
        badgeView.badgeAlignment = SSBadgeViewAlignmentRight;
        [self addSubview:badgeView];
        
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    [kBorderTopImage drawInRect:CGRectMake(0, 0, self.frame.size.width, 1)];
    [kBackgroundImage drawInRect:CGRectMake(0, 1, self.frame.size.width, self.frame.size.height - 2)];
    [kBorderBottomImage drawInRect:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
}


@end
