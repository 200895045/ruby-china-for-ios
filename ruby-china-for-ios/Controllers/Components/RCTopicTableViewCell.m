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

#define kTitleTextColor [UIColor colorWithRed:0.3255 green:0.3294 blue:0.3373 alpha:1.0000]
#define kTitleFontSize 14
#define kSubTextColor [UIColor colorWithRed:0.8078 green:0.8118 blue:0.8196 alpha:1.0000]
#define kSubTextFontSize 12

#define kBadgeColor [UIColor colorWithRed:0.1098 green:0.4980 blue:0.8588 alpha:1.0000]
#define kBadgeWidth 40

#define kBackgrounImage [UIImage imageNamed:@"tableview_cell_bg.png"]
#define kBorderTopImage [UIImage imageNamed:@"tableview_cell_border_top.png"]
#define kBorderBottomImage [UIImage imageNamed:@"tableview_cell_border_bottom.png"]

@implementation RCTopicTableViewCell

- (id) initWithTopic: (RCTopic *) aTopic {
    return [self initWithTopic:aTopic forDetail:NO];
}

- (id) initWithTopic: (RCTopic *) aTopic forDetail:(BOOL)isForDetail {
    self = [super initWithStyle:UITableViewCellSelectionStyleGray reuseIdentifier:[NSString stringWithFormat:@"topic-%d", [aTopic.remoteID intValue]]];

    topic = aTopic;
    
    if (self) {
        
//        self.backgroundColor = [UIColor whiteColor];
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
        [avatarImageView setImageWithURL:[NSURL URLWithString:topic.user.avatarUrl] placeholderImage:[RCUser defaultAvatarImage]];
        [self addSubview:avatarImageView];
        
        int titleWidth = self.frame.size.width - avatarImageView.frame.size.width - 30 - kBadgeWidth;
        CGSize titleSize = [topic.title sizeWithFont:[UIFont systemFontOfSize:kTitleFontSize]
                                   constrainedToSize:CGSizeMake(titleWidth, MAXFLOAT)
                                       lineBreakMode:NSLineBreakByWordWrapping];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.frame.size.width + avatarImageView.frame.origin.x + 10, avatarImageView.frame.origin.y - 2, titleWidth, MAX(18, MIN(36, titleSize.height)))];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 3;
        [titleLabel setText:topic.title];
        [titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
        [titleLabel setTextColor:kTitleTextColor];
        [self.contentView addSubview:titleLabel];
        
        
        // Info
        NSString *info = [NSString stringWithFormat:@" %@ • %@ ",topic.nodeName,topic.user.login];
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x - 3, titleLabel.frame.size.height + titleLabel.frame.origin.y + 5, self.frame.size.width - 150, 14)];
        [infoLabel setText:info];
        infoLabel.backgroundColor = [UIColor clearColor];
        [infoLabel setFont:[UIFont systemFontOfSize:kSubTextFontSize]];
        [infoLabel setTextColor:kSubTextColor];
        [self addSubview:infoLabel];
        
               
        if (isForDetail) {
            bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, infoLabel.frame.origin.y + 20, titleWidth, 14)];
            [bodyLabel setText:topic.bodyHtml];
            bodyLabel.backgroundColor = [UIColor clearColor];
            bodyLabel.font = [UIFont systemFontOfSize:13];
            bodyLabel.numberOfLines = 10;
            [bodyLabel setLineBreakMode:NSLineBreakByWordWrapping];
            bodyLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:bodyLabel];
        }
        else {
            badgeView = [[SSBadgeView alloc] initWithFrame:CGRectMake(self.frame.size.width - kBadgeWidth - 10, 10, kBadgeWidth, 16)];
            badgeView.textLabel.text = [NSString stringWithFormat:@"%d",topic.repliesCount.intValue];
            badgeView.backgroundColor = [UIColor clearColor];
            badgeView.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
            badgeView.cornerRadius = 8;
            badgeView.badgeColor = kBadgeColor;
            badgeView.badgeAlignment = SSBadgeViewAlignmentRight;
            [self addSubview:badgeView];
        }
        
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [kBorderTopImage drawInRect:CGRectMake(0, 0, self.frame.size.width, 1)];
    [kBackgrounImage drawInRect:CGRectMake(0, 1, self.frame.size.width, self.frame.size.height - 2)];
    [kBorderBottomImage drawInRect:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    [super drawRect:rect];
}


@end
