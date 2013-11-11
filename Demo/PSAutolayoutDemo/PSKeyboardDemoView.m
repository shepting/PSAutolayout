//
//  PSKeyboardDemoView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/11/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSKeyboardDemoView.h"
#import "UIView+LayoutAdditions.h"

@implementation PSKeyboardDemoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] init];
        [self addSubview:self.tableView];
        
        self.textField = [[UITextField alloc] init];
        [self addSubview:self.textField];
        
        self.backgroundColor = [UIColor blueColor];
        
        [self updateConstraints];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = @{@"text": self.textField,
                            @"table": self.tableView};
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Vertical
    [self addVisualConstraints:@"V:|[table][text(40)]|" views:views];
    
    // Horizontal
    [self addVisualConstraints:@"H:|[table]|" views:views];
    [self addVisualConstraints:@"H:|[text]|" views:views];
}

@end
