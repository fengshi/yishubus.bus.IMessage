//
//  ShowMessageCell.m
//  IMessage
//
//  Created by shi feng on 13-6-17.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "ShowMessageCell.h"
#import "JSBadgeView.h"

@implementation ShowMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initDraw:(NSMutableDictionary *) directionary
{
    UIImage *headImage = [directionary objectForKey:@"head"];
    NSString *msg = [directionary objectForKey:@"msg"];
    NSString *time = [directionary objectForKey:@"time"];
    NSString *name = [directionary objectForKey:@"name"];
    NSNumber *unload = [directionary objectForKey:@"unload"];
    
    self.name.text = name;
    self.talktime.text = time;
    self.msg.text = msg;
    
    self.tView.image = headImage;
    
    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.tView alignment:JSBadgeViewAlignmentTopRight];
    if (unload >= 0) {
        badgeView.badgeText = [unload stringValue];
    }

}
@end
