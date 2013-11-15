//
//  PSMessagesView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMessagesView.h"
#import "UIView+LayoutAdditions.h"

@implementation PSMessagesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.estimatedRowHeight = 120;
        [self addSubview:self.tableView];
        
        [self updateConstraints];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = @{
                            @"table": self.tableView,
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Vertical
    [self addVisualConstraints:@"V:|[table]|" views:views];
    
    // Horizontal
    [self addVisualConstraints:@"H:|[table]|" views:views];
}

@end
