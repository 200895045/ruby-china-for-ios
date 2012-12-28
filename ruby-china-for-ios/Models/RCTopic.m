//
//  RCTopic.m
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//
#import <RestKit.h>
#import "RCTopic.h"
#import "RCUser.h"
#import "RCNode.h"
#import "RCReply.h"

@implementation RCTopic
@synthesize user, node, lastReplyUserId, lastReplyUserLogin, replies, title, body, bodyHtml, repliesCount, repliedAt, nodeId, nodeName, hits;

- (void) createReply: (RCReply *) reply async: (void (^)(id object, NSError *error)) async {   
    reply.topicId = self.ID;
    [[RKObjectManager sharedManager] sendObject:reply
                                 toResourcePath:[NSString stringWithFormat:@"/topics/%@/replies",self.ID]
                                     usingBlock:^(RKObjectLoader *loader) {
        loader.method = RKRequestMethodPOST;
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[RCReply class]];
        loader.serializationMapping = [[RKObjectManager sharedManager].mappingProvider serializationMappingForClass:[RCReply class]];
        loader.onDidLoadObject = ^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(object, nil);
            });
        };
        loader.onDidFailWithError = ^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(nil, error);
            });
        };
    }];
}

@end
