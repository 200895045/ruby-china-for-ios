//
//  RCButton.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RCButton.h"

@implementation RCButton

- (RCButton *) initWithFrame:(CGRect)frame withColor:(RCButtonColor)color withSize:(RCButtonSize)size {
    frame.size.height = [self heightWithSize:size];
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font      = [UIFont systemFontOfSize:[self fontSizeWithSize:size]];
        self.backgroundColor      = [self colorWithButtonColor:color];
        [self setTitleColor:kButtonTextColor forState:UIControlStateNormal];
        [self setTitleColor:kButtonTextHighlightColor forState:UIControlStateHighlighted];
        self.layer.cornerRadius   = kButtonRedius;
    }
    
    return self;
}

- (RCButton *)initWithFrame:(CGRect)frame withColor:(RCButtonColor)color {
    return [self initWithFrame:frame withColor:color withSize:RCButtonSizeNormal];
}

- (RCButton *)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withColor:RCButtonColorBlue withSize:RCButtonSizeNormal];
}

- (float) heightWithSize: (RCButtonSize)size {
    switch (size) {
        case RCButtonSizeLarge:
            return 45;
            break;
        case RCButtonSizeNormal:
            return 35;
            break;
        case RCButtonSizeSmall:
            return 25;
            break;
        default:
            return 20;
            break;
    }
}

- (float) fontSizeWithSize: (RCButtonSize) size {
    switch (size) {
        case RCButtonSizeLarge:
            return 20;
            break;
        case RCButtonSizeNormal:
            return 18;
            break;
        case RCButtonSizeSmall:
            return 14;
            break;
        default:
            return 12;
            break;
    }
}

- (UIColor *) colorWithButtonColor: (RCButtonColor) color {
    switch (color) {
        case RCButtonColorBlue:
            return kBlueColor;
            break;
        case RCButtonColorGreen:
            return kGreenColor;
            break;
        case RCButtonColorRed:
            return kRedColor;
            break;
        default:
            return kBlackColor;
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
