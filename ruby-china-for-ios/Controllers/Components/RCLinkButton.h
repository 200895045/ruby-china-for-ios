//
//  RCLinkButton.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCLinkButton : UIButton {
    UIColor *textColor;
}

- (RCLinkButton *) initWithFrame:(CGRect)frame withTitle:(NSString *)title withTextColor:(UIColor *) aColor;
- (RCLinkButton *) initWithFrame:(CGRect)frame withTitle:(NSString *)title;
@end
