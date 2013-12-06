//
//  PSAnimatePositionView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 12/5/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSAnimatePositionView.h"
#import "UIView+LayoutAdditions.h"

@implementation PSAnimatePositionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.redView = [[UIView alloc] init];
        self.redView.backgroundColor = [UIColor redColor];
        [self addSubview:self.redView];
        
        self.blueView = [[UIView alloc] init];
        self.blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.blueView];
        
    }
    return self;
}

- (void)didMoveToSuperview
{
    NSDictionary *views = @{@"red": self.redView,
                            @"blue": self.blueView,
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Red
    [self addVisualConstraints:@"V:|-100-[red(50)]" views:views];
    [self addVisualConstraints:@"H:[red(30)]-50-|" views:views];
    
    // Blue
    [self addVisualConstraints:@"V:[blue(70)]-50-|" views:views];
    [self addVisualConstraints:@"H:|-100-[blue(100)]" views:views];
}

@end
