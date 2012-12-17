//
//  RCPreferences.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-15.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCPreferences.h"

@implementation RCPreferences

+ (NSString *) privateToken {
    return [[self userDefatuls] stringForKey:@"private_token"];
}
+ (void)setPrivateToken:(NSString *)value {
    [self setValue:value forKey:@"private_token"];
}

+ (NSString *) login {
   return [[self userDefatuls] stringForKey:@"login"];
}
+ (void) setLogin: (NSString *)value {
   [self setValue:value forKey:@"login"];
}

+ (NSString *) password {
   return [[self userDefatuls] stringForKey:@"password"];
}
+ (void) setPassword:(NSString *)value {
   [self setValue:value forKey:@"password"];
}

#pragma mark - Private
+ (NSUserDefaults *) userDefatuls {
    return [NSUserDefaults standardUserDefaults];
}

+ (void) setValue:(id) value forKey:(NSString *) key {
    [[self userDefatuls] setValue:value forKey:key];
    [[self userDefatuls] synchronize];
}


@end
