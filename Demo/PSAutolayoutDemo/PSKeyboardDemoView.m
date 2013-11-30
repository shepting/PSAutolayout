//
//  PSKeyboardDemoView.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/11/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSKeyboardDemoView.h"
#import "UIView+LayoutAdditions.h"
#import "YMKeyboardLayoutHelperView.h"

@interface PSKeyboardDemoView ()
@property (nonatomic, strong) UIView *composeView;
@property (nonatomic, strong) UIButton *sendButton;
@end

@implementation PSKeyboardDemoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.rowHeight = 70;
        [self addSubview:self.tableView];
        
        self.composeView = [[UIView alloc] init];
        self.composeView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.composeView];
        
        self.sendButton = [[UIButton alloc] init];
        [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [self.composeView addSubview:self.sendButton];
        
        self.textField = [[UITextField alloc] init];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.composeView addSubview:self.textField];
        
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
                            @"table": self.tableView,
                            @"composeView" : self.composeView,
                            @"textInput": self.textField,
                            @"sendButton" : self.sendButton,
                            @"helper": self.keyboardHelper
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // Vertical
    [self addVisualConstraints:@"V:|[table][composeView(40)][helper]|" views:views];

    // Horizontal
    [self addVisualConstraints:@"H:|[table]|" views:views];
    [self addVisualConstraints:@"H:|[composeView]|" views:views];
    
    [self.sendButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    // Compose View
    [self addVisualConstraints:@"V:|-3-[textInput]-3-|" views:views];
    [self addVisualConstraints:@"H:|-3-[textInput]-6-[sendButton]-6-|" options:NSLayoutFormatAlignAllCenterY views:views];
}

@end
