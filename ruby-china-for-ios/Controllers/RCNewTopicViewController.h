//
//  RCNewTopicViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTextView.h"
#include <ASIHTTPRequest.h>
#import "RCViewController.h"

@class RCNode;

@interface RCNewTopicViewController : RCViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,ASIHTTPRequestDelegate> {
    IBOutlet RCTextView *titleTextView;
    IBOutlet RCTextView *bodyTextView;
    
    IBOutlet UIButton *nodeButton;
    
    UIPickerView *pickerView;
    RCNode *selectedNode;
    
    UIImagePickerController *imagePicker;
}

+ (RCNewTopicViewController *) shared;

- (IBAction)nodeButtonClick:(id)sender;
- (IBAction)photoButtonClick:(id)sender;
- (IBAction)cancelButtonClick:(id)sender;

@end
