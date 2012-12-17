//
//  RCNewTopicViewController.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@class RCNode;

@interface RCNewTopicViewController : UIViewController {
    IBOutlet UITextView *titleTextView;
    IBOutlet UITextView *bodyTextView;
    
    IBOutlet UIButton *nodeButton;
    
    UIPickerView *pickerView;
    RCNode *selectedNode;
}

+ (RCNewTopicViewController *) shared;

- (IBAction)nodeButtonClick:(id)sender;
- (IBAction)photoButtonClick:(id)sender;

@end
