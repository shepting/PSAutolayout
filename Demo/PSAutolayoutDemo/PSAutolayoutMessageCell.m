//
//  PSAutolayoutMessageCell.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/13/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSAutolayoutMessageCell.h"
#import "UIView+LayoutAdditions.h"

@implementation PSAutolayoutMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.mugshotView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_avatar"]];
        [self.contentView addSubview:self.mugshotView];
        
        // Initialization code
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = @"David Hanson";
        self.nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.text = @"Jun 13, 2013";
        self.dateLabel.font = [UIFont systemFontOfSize:12.0];
        self.dateLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.dateLabel];
        
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.text = @"First off, we should really be ensuring that we make good decisions going forward.";
        self.messageLabel.font = [UIFont systemFontOfSize:12.0];
        self.messageLabel.preferredMaxLayoutWidth = 200;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
        
        self.likeButton = [[UIButton alloc] init];
        [self.likeButton setTitle:@"Like" forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.likeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.likeButton];
        
        self.replyButton = [[UIButton alloc] init];
        [self.replyButton setTitle:@"Reply" forState:UIControlStateNormal];
        [self.replyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.replyButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.replyButton];
        
        [self setupConstraints];
    }

    return self;
}

- (void)setupConstraints
{
    NSDictionary *views = @{
                            @"mugshot" : self.mugshotView,
                            @"date" : self.dateLabel,
                            @"name" : self.nameLabel,
                            @"message" : self.messageLabel,
                            @"like" : self.likeButton,
                            @"reply" : self.replyButton,
                            };
    
    for (UIView *view in [views allValues]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutFormatOptions topAndBottom = NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop;
    
    // Horizontal
    [self.contentView addVisualConstraints:@"H:|-13-[mugshot(40)]-[name]" views:views];
    [self.contentView addVisualConstraints:@"H:[mugshot]-[message]-|" views:views];
    [self.contentView addVisualConstraints:@"H:[name]-(>=8)-[date]-|" options:topAndBottom views:views];
    [self.contentView addVisualConstraints:@"H:[reply]-[like]-|" options:topAndBottom views:views];
    
    // Vertical
    [self.contentView addVisualConstraints:@"V:|-13-[mugshot(40)]" views:views];
    //        [self.contentView addVisualConstraints:@"V:|-10-[date][message(>=10)]-6-|" views:views];
    [self.contentView addVisualConstraints:@"V:|-10-[date][message(>=10)][like]-6-|" views:views];
    
    
}

@end
