//
//  PSKeyboardDemoViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/11/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSKeyboardDemoViewController.h"
#import "PSKeyboardDemoView.h"
#import "YMKeyboardLayoutHelperView.h"
#import "PSMessageCell.h"
#import "PSMessagesWithComposeView.h"

@interface PSKeyboardDemoViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) id <KeyboardDemoView> demoView;
@property (nonatomic, strong) PSMessageCell *calculationCell;
@property (nonatomic, assign) BOOL showComposeButton;
@end

static NSString *reuseIdentifier = @"StandardCell";

@implementation PSKeyboardDemoViewController

- (instancetype)initWithComposeButton
{
    self = [super init];
    if (self) {
        _showComposeButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Autolayout Cells";
    
    if (self.showComposeButton) {
        self.demoView = [[PSMessagesWithComposeView alloc] init];
    } else {
        self.demoView = [[PSKeyboardDemoView alloc] init];
    }
    self.view = (UIView *)self.demoView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tap];
    
    self.demoView.tableView.dataSource = self;
    self.demoView.tableView.delegate = self;
    
    if (!self.showComposeButton) {
        self.demoView.keyboardHelper.scrollView = self.tableView;
        self.demoView.keyboardHelper.inputView = self.demoView.textField;
    }
    
    [self.demoView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (void)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.demoView.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell Number: %li", (long)indexPath.row];
    
    return cell;
}

@end
