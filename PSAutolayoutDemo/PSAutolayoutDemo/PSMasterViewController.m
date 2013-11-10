//
//  PSMasterViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/9/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMasterViewController.h"

#import "PSDetailViewController.h"

@implementation PSMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demos";
    
    self.demoScreens = @[@"KeyboardHelper",
                         @"StaticCompose",
                         @"ThreeUp",
                         @"MessagingCell"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = self.demoScreens[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
