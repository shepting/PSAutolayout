//
//  PSMasterViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/9/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMasterViewController.h"
#import "PSKeyboardDemoViewController.h"

@implementation PSMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demos";
    
    self.demoScreens = @[@"KeyboardHelper",
                         @"StaticCompose",
                         @"ThreeUp",
                         @"MessagingCell"];
    
//    self.tableView = [[UITableView alloc] init];
//    self.tableView.delegate = self;
//    self.view = self.tableView;
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
    }
    NSLog(@"%@", demoName);
}

@end
