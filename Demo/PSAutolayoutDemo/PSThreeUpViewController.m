//
//  PSThreeUpViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSThreeUpViewController.h"
#import "PSThreeUpView.h"
@interface PSThreeUpViewController ()

@end

@implementation PSThreeUpViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Three Up";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[PSThreeUpView alloc] init];
}

@end
