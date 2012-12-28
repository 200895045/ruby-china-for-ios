//
//  RCTableView.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTableView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCTableView

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
}

@end
