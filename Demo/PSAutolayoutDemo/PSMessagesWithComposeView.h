//
//  PSMessagesWithComposeView.h
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSKeyboardDemoView.h"

@class YMKeyboardLayoutHelperView;

@interface PSMessagesWithComposeView : UIView <KeyboardDemoView>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YMKeyboardLayoutHelperView *keyboardHelper;
@property (nonatomic, strong) UIView *composeButton;

@end
