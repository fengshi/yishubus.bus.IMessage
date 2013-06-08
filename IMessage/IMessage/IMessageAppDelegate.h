//
//  IMessageAppDelegate.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"
#import "MessageReceiveDelegate.h"

@interface IMessageAppDelegate : UIResponder <UIApplicationDelegate>
{
    XMPPStream *xmppStream;
    BOOL isOpenStream;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XMPPStream *xmppStream;
@property (nonatomic, retain) id<MessageReceiveDelegate> messageReceiveDelegate;

- (BOOL) connect;
- (void) disconnect;
- (void) setupStream;

@end
