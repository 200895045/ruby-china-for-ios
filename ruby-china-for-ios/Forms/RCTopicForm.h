//
//  RCTopicForm.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <Survey/SurveyFormModel.h>
#import <Survey/SurveyField.h>

@interface RCTopicForm : SurveyFormModel <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *nodePicker;
    UIView *view;
    NSArray *nodes;
}
@property (nonatomic,strong) SurveyField *title;
@property (nonatomic,strong) SurveyField *nodeName;
@property (nonatomic,strong) SurveyField *body;
@property (nonatomic,strong) NSNumber *nodeId;

- (id) init: (UIView *) superView;
@end
