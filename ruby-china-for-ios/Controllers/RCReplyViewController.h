//
//  RCReplyViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTextView.h"
#include <ASIHTTPRequest.h>
#include <ASIFormDataRequest.h>

@interface RCReplyViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,ASIHTTPRequestDelegate> {
    IBOutlet RCTextView *bodyTextView;
    
    RCTopic *topic;
    
    UIImagePickerController *imagePicker;
}

+ (RCReplyViewController *) shared;

- (void) setTopic: (RCTopic *) aTopic;

- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)submitButtonClick:(id)sender;
- (IBAction)photoButtonClick:(id)sender;

@end
