//
//  PSAutolayoutMessageCell.h
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/13/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSMessageCell : UITableViewCell

@property (nonatomic) UIImageView *mugshotView;
@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *likeButton;
@property (nonatomic) UIButton *replyButton;

@property (nonatomic) UIScrollView *attachments;

@end
