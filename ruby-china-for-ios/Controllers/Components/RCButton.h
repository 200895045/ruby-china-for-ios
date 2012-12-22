//
//  RCButton.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RCButtonSize) {
    RCButtonSizeTiny,
    RCButtonSizeSmall,                  // regular table view
    RCButtonSizeNormal,
    RCButtonSizeLarge // preferences style table view
};

typedef NS_ENUM(NSInteger, RCButtonColor) {
    RCButtonColorRed,
    RCButtonColorBlue,
    RCButtonColorGreen,
    RCButtonColorBlack
};


@interface RCButton : UIButton

- (RCButton *) initWithFrame:(CGRect)frame withColor:(RCButtonColor)color withSize:(RCButtonSize)size;
- (RCButton *) initWithFrame:(CGRect)frame withColor:(RCButtonColor)color;
- (RCButton *) initWithFrame:(CGRect)frame;

@end
