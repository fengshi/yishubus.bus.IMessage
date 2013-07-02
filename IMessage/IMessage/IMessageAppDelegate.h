//
//  IMessageAppDelegate.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@interface IMessageAppDelegate : UIResponder <UIApplicationDelegate>
{
    XMPPStream *xmppStream;
    BOOL isOpenStream;
    UIImageView *startImageView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XMPPStream *xmppStream;
@property (nonatomic, retain) id messageReceiveDelegate;

- (BOOL) connect;
- (void) disconnect;
- (void) setupStream;
-(void)goOnline;
-(void)goOffline;
@end
