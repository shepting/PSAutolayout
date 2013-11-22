//
//  UIView+LayoutAdditions.h
//  Landshark
//
//  Created by Steven Hepting on 3/5/13.
//  Copyright (c) 2013 Yammer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutAdditions)

- (void)addVisualConstraints:(NSString *)format views:(NSDictionary *)views;
- (void)addVisualConstraints:(NSString *)format options:(NSLayoutFormatOptions)opts views:(NSDictionary *)views;
- (void)overlayView:(UIView *)view1 ontoView:(UIView *)view2;
- (void)centerHorizontally;
- (void)centerVertically;
- (void)equateAttribute:(NSLayoutAttribute)attribute onView:(UIView *)view1 andView:(UIView *)view2;

@end
