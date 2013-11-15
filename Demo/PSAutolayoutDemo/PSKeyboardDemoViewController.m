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

@interface PSKeyboardDemoViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) PSKeyboardDemoView *demoView;
@property (nonatomic, strong) PSMessageCell *calculationCell;
@end

static NSString *reuseIdentifier = @"StandardCell";

@implementation PSKeyboardDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Autolayout Cells";
    
    self.demoView = [[PSKeyboardDemoView alloc] init];
    self.view = self.demoView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tap];
    
    self.demoView.tableView.dataSource = self;
    self.demoView.tableView.delegate = self;
    
    self.demoView.keyboardHelper.scrollView = self.tableView;
    self.demoView.keyboardHelper.inputView = self.demoView.textField;
    
    [self.demoView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (void)backgroundTapped:(id)sender
{
    [self.demoView endEditing:YES];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.demoView.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell Number: %i", indexPath.row];
    
    return cell;
}

@end
