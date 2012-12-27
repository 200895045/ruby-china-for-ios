//
//  RCTextView.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTextView.h"

@implementation RCTextView

@synthesize placeholders;


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //
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
- (BOOL)becomeFirstResponder {
    [self setNeedsDisplay];
    return [super becomeFirstResponder];
}


- (BOOL)resignFirstResponder
{
    [self setNeedsDisplay];
    return [super resignFirstResponder];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ([self.text isEqualToString:@""] && ![self isFirstResponder]) {
        [[UIColor lightGrayColor] set];
        [self.placeholders drawAtPoint:CGPointMake(6, 5) withFont:self.font];
    }
       
}

@end
