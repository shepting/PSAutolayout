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
@property (nonatomic) CGFloat keyboardY;
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
    self.keyboardY = self.keyboard.frame.origin.y;

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

- (void)panGestureDidChange:(UIPanGestureRecognizer *)gesture
{
//    CGPoint point = [gesture locationInView:self.keyboard];
//    
////    BOOL inKeyboardSpace = point.y > self.originalKeyboardOrigin.y;
//    BOOL inKeyboardSpace = point.y > 0;
//    CGRect kFrame = self.keyboard.frame;
//    CGFloat maxKeyboardY = CGRectGetMaxY(kFrame);
//
    CGFloat keyboardViewHeight = self.keyboard.bounds.size.height;
    CGFloat keyboardWindowHeight = self.keyboard.window.bounds.size.height;
    CGPoint touchLocationInKeyboardWindow = [gesture locationInView:self.keyboard.window];
//    //    BOOL offBottom =
//    
//    if (inKeyboardSpace) {
//        self.keyboard.frame = CGRectOffset(self.keyboard.frame, 0, point.y);
//    }
    
    // If touch is inside trigger offset, then disable keyboard input
    if (touchLocationInKeyboardWindow.y > keyboardWindowHeight - keyboardViewHeight - 44.0)
    {
        self.keyboard.userInteractionEnabled = NO;
    }
    else
    {
        self.keyboard.userInteractionEnabled = YES;
    }
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            // For the duration of this gesture, do not recognize more touches than
            // it started with
            gesture.maximumNumberOfTouches = gesture.numberOfTouches;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGRect newKeyboardViewFrame = self.keyboard.frame;
            newKeyboardViewFrame.origin.y = touchLocationInKeyboardWindow.y + 44.0;
            // Bound the keyboard to the bottom of the screen
            newKeyboardViewFrame.origin.y = MIN(newKeyboardViewFrame.origin.y, keyboardWindowHeight);
            newKeyboardViewFrame.origin.y = MAX(newKeyboardViewFrame.origin.y, keyboardWindowHeight - keyboardViewHeight);
            
            // Only update if the frame has actually changed
            if (newKeyboardViewFrame.origin.y != self.keyboard.frame.origin.y)
            {
//                self.keyboard.frame = newKeyboardViewFrame;
                [UIView animateWithDuration:0.0f
                                      delay:0.0f
                                    options:UIViewAnimationOptionTransitionNone | UIViewAnimationOptionBeginFromCurrentState
                                 animations:^{
                                     self.heightConstraint.constant = newKeyboardViewFrame.origin.y - keyboardWindowHeight;
                                     [self.keyboard setFrame:newKeyboardViewFrame];
                                 }
                                 completion:nil];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGFloat thresholdHeight = keyboardWindowHeight - keyboardViewHeight - 44.0 + 44.0f;
            CGPoint velocity = [gesture velocityInView:self.keyboard];
            BOOL shouldRecede;
            
            if (touchLocationInKeyboardWindow.y < thresholdHeight || velocity.y < 0)
                shouldRecede = NO;
            else
                shouldRecede = YES;
            
            // If the keyboard has only been pushed down 44 pixels or has been
            // panned upwards let it pop back up; otherwise, let it drop down
            CGRect newKeyboardViewFrame = self.keyboard.frame;
            newKeyboardViewFrame.origin.y = (!shouldRecede ? keyboardWindowHeight - keyboardViewHeight : keyboardWindowHeight);
            
            [UIView animateWithDuration:0.25f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [self.keyboard setFrame:newKeyboardViewFrame];
                                 /* Unnecessary now, due to KVO on self.keyboardActiveView
                                  CGRect newKeyboardViewFrameInView = [self convertRect:newKeyboardViewFrame
                                  fromView:self.keyboardActiveView.window];
                                  if (self.keyboardDidMoveBlock)
                                  self.keyboardDidMoveBlock(newKeyboardViewFrameInView);
                                  */
                             }
                             completion:^(__unused BOOL finished){
                                 [[self keyboard] setUserInteractionEnabled:!shouldRecede];
                                 if (shouldRecede)
                                 {
                                     [self keyboard];
                                 }
                             }];
            
            // Set the max number of touches back to the default
            gesture.maximumNumberOfTouches = NSUIntegerMax;
        }
            break;
        default:
            break;
    }
//    NSLog(@"Pan gesture: %f", point.y);
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
