//
//  PSAnimatePositionViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 12/5/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSAnimatePositionViewController.h"
#import "PSAnimatePositionView.h"

@interface PSAnimatePositionViewController ()

@end

@implementation PSAnimatePositionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.positionView = [[PSAnimatePositionView alloc] init];
    self.view = self.positionView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewWithRecognizer:)];
    [self.positionView.redView addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panViewWithRecognizer:)];
    [self.positionView.blueView addGestureRecognizer:pan];
}

- (void)popViewWithRecognizer:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSLog(@"Tapped view: %@", view);
    
    // Make it large
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        // Animate it back
        [UIView animateWithDuration:0.3 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)panViewWithRecognizer:(UIPanGestureRecognizer *)pan
{
    UIView *view = pan.view;
    
    NSLog(@"Dragging: %@", view);
    
    CGPoint translation = [pan translationInView:self.view];
    CGPoint viewPosition = view.center;
    viewPosition.x += translation.x;
    viewPosition.y += translation.y;
    
    view.center = viewPosition;
    [pan setTranslation:CGPointZero inView:self.view];

}

@end
