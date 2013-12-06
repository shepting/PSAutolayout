//
//  PSMasterViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/9/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMasterViewController.h"
#import "PSKeyboardDemoViewController.h"
#import "PSThreeUpViewController.h"
#import "PSMessagesViewController.h"
#import "PSAnimatePositionViewController.h"

@implementation PSMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demos";
    
    self.demoScreens = @[@"ThreeUp",
                         @"StaticCompose",
                         @"KeyboardHelper",
                         @"MessagingCell",
                         @"Animating Position"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.demoScreens count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *demoName = self.demoScreens[indexPath.row];
    cell.textLabel.text = demoName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *demoName = self.demoScreens[indexPath.row];
    
    if ([demoName isEqualToString:@"KeyboardHelper"]) {
        UIViewController *vc = [[PSKeyboardDemoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([demoName isEqualToString:@"ThreeUp"]) {
        UIViewController *vc = [[PSThreeUpViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([demoName isEqualToString:@"StaticCompose"]) {
        UIViewController *vc = [[PSKeyboardDemoViewController alloc] initWithComposeButton];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([demoName isEqualToString:@"MessagingCell"]) {
        UIViewController *vc = [[PSMessagesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([demoName isEqualToString:@"Animating Position"]) {
        UIViewController *vc = [[PSAnimatePositionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    NSLog(@"%@", demoName);
}

@end
