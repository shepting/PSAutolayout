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

NSString *PSDemoStaticCompose = @"Hovering Compose";
NSString *PSDemoThreeHorizontal = @"Three Horizontal";
NSString *PSDemoKeyboardHelper = @"Keyboard Helper";
NSString *PSDemoAutolayoutCell = @"Autolayout Cell";
NSString *PSDemoDraggableViews = @"Draggable Views";

@implementation PSMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demos";
    
    self.demoScreens = @{PSDemoStaticCompose : [[PSKeyboardDemoViewController alloc] initWithComposeButton],
                         PSDemoThreeHorizontal : [[PSThreeUpViewController alloc] init],
                         PSDemoKeyboardHelper : [[PSKeyboardDemoViewController alloc] init],
                         PSDemoAutolayoutCell : [[PSMessagesViewController alloc] init],
                         PSDemoDraggableViews : [[PSAnimatePositionViewController alloc] init],
                         };
    
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

    NSString *demoName = [self.demoScreens allKeys][indexPath.row];
    cell.textLabel.text = demoName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *demoName = [self.demoScreens allKeys][indexPath.row];
    NSLog(@"%@", demoName);
    
    UIViewController *vc = self.demoScreens[demoName];
    vc.title = demoName;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
