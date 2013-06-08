//
//  MessageReceiveDelegate.h
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageReceiveDelegate <NSObject>

- (void) messageReceive:(NSDictionary *) messageContent;

@end
