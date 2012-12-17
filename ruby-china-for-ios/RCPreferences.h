//
//  RCPreferences.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-15.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCPreferences : NSObject {
    
}

+ (NSString *) privateToken;
+ (void)setPrivateToken:(NSString *)value;

+ (NSString *) login;
+ (void) setLogin: (NSString *)value;

+ (NSString *) password;
+ (void) setPassword: (NSString *)value;

@end
