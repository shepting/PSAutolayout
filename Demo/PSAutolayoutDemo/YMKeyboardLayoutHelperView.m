//
//  YMKeyboardLayoutHelperView.m
//  ios-chat
//
//  Created by Steven Hepting on 7/17/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YMKeyboardLayoutHelperView.h"
#import "UIView+LayoutAdditions.h"

@interface YMKeyboardLayoutHelperView ()
@property (nonatomic) CGFloat duration;
@property (nonatomic) UIViewAnimationCurve animationCurve;
@property (nonatomic) NSLayoutConstraint *heightConstraint;
@property (nonatomic) UIGestureRecognizer *panRecognizer;
@property (nonatomic) UIGestureRecognizer *tapRecognizer;
@property (nonatomic) UIView *inputAccessoryView;
@property (nonatomic, weak) UIView *keyboard;
@property (nonatomic) CGPoint originalKeyboardOrigin;
@end

@implementation YMKeyboardLayoutHelperView

- (id)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        NSDictionary *views = @{@"self": self};
        self.heightConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(0)]" options:0 metrics:nil views:views] lastObject];
        [self addConstraint:self.heightConstraint];
        [self addVisualConstraints:@"H:[self(100)]" views:views];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow:(NSNotification *)notification
{
    // Save the height of keyboard and animation duration
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedRect = [self convertRect:keyboardRect fromView:nil]; // Convert from window coordinates
    self.animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    self.duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.heightConstraint.constant = CGRectGetHeight(convertedRect);
    
    
    [self animateSizeChange];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    self.keyboard = self.inputView.inputAccessoryView.superview;
    self.originalKeyboardOrigin = self.keyboard.frame.origin;

}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.heightConstraint.constant = 0.0f;
    
    [self animateSizeChange];
    
    [self.scrollView removeGestureRecognizer:self.panRecognizer];
}

#pragma mark - Panning

- (void)setScrollView:(UIScrollView *)scrollView
{
    // Register for gesture recognizer calls
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDidChange:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setDelegate:self];
    [panGesture setCancelsTouchesInView:NO];
    self.panRecognizer = panGesture;
    [scrollView addGestureRecognizer:self.panRecognizer];
    
    _scrollView = scrollView;
}

- (void)setInputView:(UITextField *)inputView
{
    self.inputAccessoryView = [[UIView alloc] init];
    inputView.inputAccessoryView = self.inputAccessoryView;
    _inputView = inputView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.panRecognizer) {
        return YES;
    }
    
    return NO;
}

- (void)panGestureDidChange:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.keyboard];
    
//    BOOL inKeyboardSpace = point.y > self.originalKeyboardOrigin.y;
    BOOL inKeyboardSpace = point.y > 0;

    
    if (inKeyboardSpace) {
        self.keyboard.frame = CGRectOffset(self.keyboard.frame, 0, point.y);
//        self.keyboard.frame = CGRectMake(0, point.y, CGRectGetWidth(self.keyboard.frame), CGRectGetHeight(self.keyboard.frame));
    }
    NSLog(@"Pan gesture: %f", point.y);
}

#pragma mark - Auto Layout

- (void)animateSizeChange
{
    [self setNeedsUpdateConstraints];
    
    // Left shift to change animationCurve to animationOptions
    // (see UIViewAnimationOptions docs/header for constants enum)
    UIViewAnimationOptions options = self.animationCurve << 16;
    
    // Animate transition
    [UIView animateWithDuration:self.duration delay:0 options:options animations:^{
        [self.superview layoutIfNeeded];
    } completion:nil];
}

@end
