//
//  TalkMessageCell.m
//  IMessage
//
//  Created by shi feng on 13-6-19.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "TalkMessageCell.h"
#import "TalkMessage.h"

@implementation TalkMessageCell
@synthesize contextLabel;
@synthesize bubImage;
@synthesize headerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        [self.contentView addSubview:headerLabel];
        
        bubImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bubImage];
        
        contextLabel = [[UILabel alloc] init];
        contextLabel.backgroundColor = [UIColor clearColor];
        contextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contextLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        [self.contentView addSubview:contextLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
