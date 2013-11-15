//
//  PSThreeUpView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSThreeUpView.h"
#import "UIView+LayoutAdditions.h"

@implementation PSThreeUpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.red = [[UIView alloc] init];
        self.red.backgroundColor = [UIColor redColor];
        [self addSubview:self.red];
        
        self.green = [[UIView alloc] init];
        self.green.backgroundColor = [UIColor greenColor];
        [self addSubview:self.green];
        
        self.blue = [[UIView alloc] init];
        self.blue.backgroundColor = [UIColor blueColor];
        [self addSubview:self.blue];
        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    NSDictionary *views = @{
                            @"red": self.red,
                            @"green": self.green,
                            @"blue": self.blue,
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Vertical
    [self addVisualConstraints:@"V:|-100-[red]-100-|" views:views];
    
    
    // Horizontal
    [self addVisualConstraints:@"H:|-[red(>=50)]-[green(==red)]-[blue(==red)]-|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom views:views];
}

@end
