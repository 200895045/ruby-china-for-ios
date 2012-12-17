//
//  RCReply.h
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//


#import "RCBaseModel.h"

@class RCUser;
@class RCTopic;

@interface RCReply : RCBaseModel

@property (nonatomic, strong) RCUser *user;
@property (nonatomic, strong) NSString *body, *bodyHtml;
@property (nonatomic, strong) NSNumber *topicId;

@end
