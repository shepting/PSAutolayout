//
//  UIView+LayoutAdditions.m
//  Landshark
//
//  Created by Steven Hepting on 3/5/13.
//  Copyright (c) 2013 Yammer, Inc. All rights reserved.
//

#import "UIView+LayoutAdditions.h"

@implementation UIView (LayoutAdditions)

- (void)addVisualConstraints:(NSString *)format views:(NSDictionary *)views
{
    [self addVisualConstraints:format options:0 views:views];
}

- (void)addVisualConstraints:(NSString *)format options:(NSLayoutFormatOptions)opts views:(NSDictionary *)views
{
    for (UIView *view in [views allValues]) {
        NSAssert(view != nil, @"References to views must be non-nil");
    }
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:opts metrics:nil views:views];
    NSAssert([constraints count] != 0, @"List of contraints cannot be of size zero");
    
    [self addConstraints:constraints];
}

- (void)centerHorizontally
{
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    [self.superview addConstraint:centerX];
}

- (void)centerVertically
{
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    centerY.priority = UILayoutPriorityDefaultLow;
    
    [self.superview addConstraint:centerY];
}

- (void)overlayView:(UIView *)view1 ontoView:(UIView *)view2
{
    [self equateAttribute:NSLayoutAttributeTop onView:view1 andView:view2];
    [self equateAttribute:NSLayoutAttributeRight onView:view1 andView:view2];
    [self equateAttribute:NSLayoutAttributeLeft onView:view1 andView:view2];
    [self equateAttribute:NSLayoutAttributeBottom onView:view1 andView:view2];
}

- (void)equateAttribute:(NSLayoutAttribute)attribute onView:(UIView *)view1 andView:(UIView *)view2
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view1 attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attribute multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
}

@end
