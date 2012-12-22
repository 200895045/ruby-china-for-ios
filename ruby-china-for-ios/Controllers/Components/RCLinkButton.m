//
//  RCLinkButton.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-22.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCLinkButton.h"

@implementation RCLinkButton

- (RCLinkButton *) initWithFrame:(CGRect)frame withTitle:(NSString *)title withTextColor:(UIColor *) aColor {
    self = [super initWithFrame:frame];
    if (self) {
        textColor = aColor;
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.font      = [UIFont systemFontOfSize:13];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setTitleColor:[textColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    }
    
    return self;
}
- (RCLinkButton *) initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    return [self initWithFrame:frame withTitle:title withTextColor:kBlueColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.highlighted) {
        [[textColor colorWithAlphaComponent:0.5] set];
    }
    else {
        [textColor set];
    }
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextMoveToPoint(ctx, self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + 3);
    CGContextAddLineToPoint(ctx, self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + 3);
    
    CGContextStrokePath(ctx);
}

@end
