//
//  RCUser.m
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "RCUser.h"
#import "RCTopic.h"
#import "RCReply.h"
#import "RCNode.h"
#import "NSData+Base64.h"
#import "RCPreferences.h"

static UIImage *defaultAvatarImage;

@implementation RCUser
@synthesize email, name, twitter, location, bio, website, avatarUrl,githubUrl, tagline, login;

static RCUser *_currentUser;

- (NSString *)description {
    return [NSString stringWithFormat:@"RCUser: <ID: %d>",[self.ID intValue]];
}

+ (UIImage *) defaultAvatarImage {
    if (!defaultAvatarImage) {
        defaultAvatarImage = [UIImage imageNamed:@"default_avatar.png"];
    }
    return defaultAvatarImage;
}


+ (BOOL) authorize: (NSString *) login password:(NSString *)password {
    BOOL result = NO;

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/account/sign_in.json",kAppDomain]]];
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
        [RCPreferences setLogin:login];
        [RCPreferences setPassword:password];
        
        NSString *token = [jsonResponse objectForKey:@"private_token"];
        [RCPreferences setPrivateToken:[NSString stringWithFormat:@"%@",token]];
        
        [[[RKObjectManager sharedManager] client] setValue:token forHTTPHeaderField:@"AUTHORIZATION"];
        
        // TODO: 需要用同步的方式查询 User
        [RCUser findByStringId:login async:^(id object, NSError *error) {
            _currentUser = object;
        }];
        
        
        result = YES;
    }

    return result;
}

+ (RCUser *) currentUser {
    return _currentUser;
}

+ (void) checkLogin {
    [RCUser authorize:[RCPreferences login] password:[RCPreferences password]];
}

@end
