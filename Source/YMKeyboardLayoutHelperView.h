//
//  YMKeyboardLayoutHelperView.h
//  ios-chat
//
//  Created by Steven Hepting on 7/17/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMKeyboardLayoutHelperView : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *inputView;

@end
