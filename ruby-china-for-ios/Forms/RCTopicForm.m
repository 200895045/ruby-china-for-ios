//
//  RCTopicForm.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTopicForm.h"
#import "RCNode.h"

@implementation RCTopicForm

@synthesize title, nodeName, nodeId, body;

- (id) init: (UIView *) superView {
    self = [super init];
    
    if (self) {
        view = superView;
        
        nodePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 300, view.frame.size.width, 300)];
        nodePicker.dataSource = self;
        nodePicker.delegate = self;
        
        
        nodes = [RCNode remoteAll:nil];
        
        title = [SurveyField fieldWithPlaceholder:@"标题"];
        title.isRequired = YES;
        title.label= @"标题";
        title.shouldReturn = ^BOOL(SurveyField *this, id field) {
            SurveyField  *nextField = [this getNextField];
            
            [this resignFirstResponder];
            [nextField becomeFirstResponder];
            
            return NO;
        };
        
        nodeName = [SurveyField fieldWithPlaceholder:@"节点"];
        nodeName.isRequired = YES;
        nodeName.label = @"节点";
        nodeName.shouldBeginEditing = ^BOOL(SurveyField *this, id field) {
//            [nodePicker ]
            [view addSubview:nodePicker];
            return NO;
        };
        nodeName.shouldEndEditing = ^BOOL(SurveyField *this, id field) {
            [nodePicker removeFromSuperview];
            return YES;
        };
        
        body = [SurveyField fieldWithPlaceholder:@"正文"];
        body.isRequired = YES;
        body.label = @"正文";
        
    }
    return self;
}

+ (NSArray *) fields {
    return @[@"title", @"nodeName", @"body"];
}

#pragma mark - PickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == nodePicker) {
        return [nodes count];
    }
    
    return 0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *result = @"";
    if (pickerView == nodePicker) {
        result = ((RCNode *)[nodes objectAtIndex:row]).name;
    }
    return [[NSAttributedString alloc] initWithString:result];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    RCNode *node = [nodes objectAtIndex:row];
    [nodeName.field setText:node.name];
    nodeId = node.remoteID;
}
@end
