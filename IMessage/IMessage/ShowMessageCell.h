//
//  ShowMessageCell.h
//  IMessage
//
//  Created by shi feng on 13-6-17.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *talktime;
@property (strong, nonatomic) IBOutlet UILabel *msg;

@property (strong, nonatomic) IBOutlet UIImageView *tView;
- (void) initDraw:(NSMutableDictionary *) directionary;
@end
