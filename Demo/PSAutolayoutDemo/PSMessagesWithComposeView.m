//
//  PSMessagesWithComposeView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMessagesWithComposeView.h"
#import "UIView+LayoutAdditions.h"
#import "YMKeyboardLayoutHelperView.h"

@implementation PSMessagesWithComposeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.rowHeight = 70;
        [self addSubview:self.tableView];
        
        self.composeButton = [[UIView alloc] init];
        self.composeButton.backgroundColor = [UIColor redColor];
        [self addSubview:self.composeButton];
        
        self.keyboardHelper = [[YMKeyboardLayoutHelperView alloc] init];
        [self addSubview:self.keyboardHelper];
        
        [self updateConstraints];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = @{
                            @"compose": self.composeButton,
                            @"table": self.tableView,
                            @"helper": self.keyboardHelper
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Vertical
    [self addVisualConstraints:@"V:|[table][helper]|" views:views];
    [self addVisualConstraints:@"V:[compose(30)]-|" views:views];
    
    // Horizontal
    [self addVisualConstraints:@"H:|[table]|" views:views];
    [self addVisualConstraints:@"H:[compose(30)]-|" views:views];
}

@end
