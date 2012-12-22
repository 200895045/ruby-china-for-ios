//
//  RCLoginForm.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCLoginForm.h"
#import "RCPreferences.h"

@implementation RCLoginForm

@synthesize login, password;

- (id) init {
    self = [super init];
    
    if (self) {
        login = [SurveyField fieldWithPlaceholder:@"用户名"];
        login.isRequired = YES;
        login.keyboardType = UIKeyboardTypeEmailAddress;
        login.label= @"用户名";
        login.value = [RCPreferences login];
        login.field.clearButtonMode = UITextFieldViewModeAlways;
        login.field.delegate = self;
        login.shouldReturn = ^BOOL(SurveyField *this, id field) {
            SurveyField  *nextField = [this getNextField];
            [this resignFirstResponder];
            [nextField becomeFirstResponder];
            return NO;
        };
        
        password = [SurveyField fieldWithPlaceholder:@"密码"];
        password.isRequired = YES;
        password.isSecure = YES;
        password.value = [RCPreferences password];
        password.label = @"密码";

    }
    return self;
}

+ (NSArray *) fields {
    return @[@"login", @"password"];
}

@end
