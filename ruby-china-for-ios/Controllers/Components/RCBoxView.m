//
//  RCBoxView.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCBoxView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCBoxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kBoxRedius;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.2f, 0.2f);
        self.layer.shadowRadius = 5;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    }
    return self;
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
