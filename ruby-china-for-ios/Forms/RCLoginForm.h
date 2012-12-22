//
//  RCLoginForm.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <Survey/SurveyFormModel.h>
#import <Survey/SurveyField.h>

@interface RCLoginForm : SurveyFormModel <UITextFieldDelegate> {
    
}

@property (nonatomic,strong) SurveyField *login;
@property (nonatomic,strong) SurveyField *password;

@end
