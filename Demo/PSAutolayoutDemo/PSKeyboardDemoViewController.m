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
#import "PSAutolayoutMessageCell.h"

@interface PSKeyboardDemoViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) PSKeyboardDemoView *demoView;
@property (nonatomic, strong) PSAutolayoutMessageCell *calculationCell;
@end

static NSString *reuseIdentifier = @"StandardCell";

@implementation PSKeyboardDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Autolayout Cells";
    
    self.demoView = [[PSKeyboardDemoView alloc] init];
    self.view = self.demoView;
    
    self.demoView.tableView.delegate = self;
    self.demoView.tableView.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tap];
    
    self.demoView.keyboardHelper.scrollView = self.demoView.tableView;
    self.demoView.keyboardHelper.inputView = self.demoView.textField;
    
    [self.demoView.tableView registerClass:[PSAutolayoutMessageCell class] forCellReuseIdentifier:reuseIdentifier];
    
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
    
    self.calculationCell = [[PSAutolayoutMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                      
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (void)backgroundTapped:(id)sender
{
    NSLog(@"Background tapped.");
    [self.demoView endEditing:YES];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (PSAutolayoutMessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSAutolayoutMessageCell *cell = [self.demoView.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
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
