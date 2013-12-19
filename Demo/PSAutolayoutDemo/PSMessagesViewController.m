//
//  PSMessagesViewController.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/14/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSMessagesViewController.h"
#import "PSMessagesView.h"
#import "PSMessageCell.h"

@interface PSMessagesViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) PSMessagesView *messagesView;
@property (nonatomic, strong) PSMessageCell *calculationCell;
@end

static NSString *reuseIdentifier = @"StandardCell";

@implementation PSMessagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.messagesView = [[PSMessagesView alloc] init];
    self.view = self.messagesView;
    
    self.messagesView.tableView.delegate = self;
    self.messagesView.tableView.dataSource = self;
    
    [self.messagesView.tableView registerClass:[PSMessageCell class] forCellReuseIdentifier:reuseIdentifier];
    
    NSArray *messageTemplates = @[@"First off, we should really be ensuring that we make good decisions going forward.",
                                  @"Hey there.",
                                  @"The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today.",
                                  @"There are more than 7,500 known cultivars of apples, resulting in a range of desired characteristics. Different cultivars are bred for various tastes and uses, including cooking, fresh eating and cider production. Domestic apples are generally propagated by grafting, although wild apples grow readily from seed.",
                                  @"however, two forms of allergies are seen to various proteins found in the fruit.",
                                  @"were brought to North America by European colonists.",
                                  @"About 69 million tonnes of apples were grown worldwide in 2010, and China produced almost half of this total. The United States is the second-leading producer, with more than 6% of world production. Turkey is third, followed by Italy, India and Poland. Apples are often eaten raw, but can also be found in many prepared foods (especially desserts) and drinks. Many beneficial health",
                                  @"Meeting tomorrow."];
    
    self.messages = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        NSUInteger index = arc4random_uniform([messageTemplates count]);
        self.messages[i] = messageTemplates[index];
    }
    
    self.calculationCell = [[PSMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (PSMessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSMessageCell *cell = [self.messagesView.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.messageLabel.text = self.messages[indexPath.row];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.calculationCell.messageLabel.text = self.messages[indexPath.row];
    [self.calculationCell setNeedsUpdateConstraints];
    [self.calculationCell updateConstraintsIfNeeded];
    
    CGFloat height = [self.calculationCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //    NSLog(@"Height: %f", height);
    
    return height;
    
}

@end
