//
//  PSKeyboardDemoView.h
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/11/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMKeyboardLayoutHelperView;

@interface PSKeyboardDemoView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YMKeyboardLayoutHelperView *keyboardHelper;
@end
