//
//  RCLoginForm.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCLoginForm.h"

@implementation RCLoginForm

@synthesize login, password;

- (id) init {
    self = [super init];
    
    if (self) {
        login = [SurveyField fieldWithPlaceholder:@"login"];
        login.isRequired = YES;
        login.keyboardType = UIKeyboardTypeEmailAddress;
        login.label= @"用户名";
        login.field.clearButtonMode = UITextFieldViewModeAlways;
        login.shouldReturn = ^BOOL(SurveyField *this, id field) {
            SurveyField  *nextField = [this getNextField];
            
            [this resignFirstResponder];
            [nextField becomeFirstResponder];
            
            return NO;
        };
        
        password = [SurveyField fieldWithPlaceholder:@"password"];
        password.isRequired = YES;
        password.isSecure = YES;
        password.label = @"密码";

    }
    return self;
}

+ (NSArray *) fields {
    return @[@"login", @"password"];
}
@end
