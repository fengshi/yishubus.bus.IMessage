//
//  ShowMessageTableController.h
//  IMessage
//
//  Created by shi feng on 13-6-18.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageReceiveDelegate.h"

@interface ShowMessageTableController : UITableViewController<MessageReceiveDelegate>

@property (strong, nonatomic) NSMutableArray *messageArray;

@end
