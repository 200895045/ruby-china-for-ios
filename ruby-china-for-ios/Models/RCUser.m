//
//  RCUser.m
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "RCUser.h"

#import "RCTopic.h"
#import "RCNote.h"
#import "RCReply.h"
#import "RCPhoto.h"
#import "RCNode.h"
#import "NSData+Base64.h"
#import "RCPreferences.h"

static UIImage *defaultAvatarImage;

@implementation RCUser
@synthesize topics, notes, replies, email, name, twitter, location, bio, website, avatarUrl, tagline, login;

- (Class) nestedClassForProperty:(NSString *)property
{
    if ([property isEqualToString:@"topics"])
        return [RCTopic class];
    if ([property isEqualToString:@"notes"])
        return [RCNote class];
    if ([property isEqualToString:@"replies"])
        return [RCReply class];
    if ([property isEqualToString:@"photos"])
        return [RCPhoto class];

    return [super nestedClassForProperty:property];
}

+ (UIImage *) defaultAvatarImage {
    if (!defaultAvatarImage) {
        defaultAvatarImage = [UIImage imageNamed:@"default_avatar.png"];
    }
    return defaultAvatarImage;
}


+ (BOOL) authorize: (NSString *) login password:(NSString *)password {
    BOOL result = NO;

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://127.0.0.1:3000/account/sign_in.json"]];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", login, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [authData nsr_base64Encoding]];

    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if ([response statusCode] == 201) {
        id jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers
                                                            error:nil];
        NSString *token = [jsonResponse objectForKey:@"private_token"];
        
        [RCPreferences setPrivateToken:token];
        
        result = YES;
    }

    return result;
}

@end
