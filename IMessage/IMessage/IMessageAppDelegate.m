//
//  IMessageAppDelegate.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMessageAppDelegate.h"
#import "IMessageViewController.h"
#import "LoginViewController.h"
#import "Constants.h"
#import "IMessageService.h"
#import "SqliteData.h"

@implementation IMessageAppDelegate
@synthesize xmppStream;
@synthesize messageReceiveDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    SqliteData *util = [[SqliteData alloc] init];
//    [util removeSqlite];
//    
//    IMessageService *service = [[IMessageService alloc] init];
//    [service removeLoginMessage];
    
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"mail"];
    
    if (!login) {
        LoginViewController *loginController = [[LoginViewController alloc] init];
        self.window.rootViewController = loginController;
    } else {
        IMessageViewController *con = [[IMessageViewController alloc] init];
        self.window.rootViewController = con;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self disconnect];
}

- (void) setupStream
{
    xmppStream = [[XMPPStream alloc] init];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [xmppStream setHostName:XMPP_MAIN];
}

- (BOOL) connect
{
    [self setupStream];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults stringForKey:@"id"];
    NSString *pass = [defaults stringForKey:@"pass"];

    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    if (userId == nil || pass == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:[userId stringByAppendingString:OPEN_FILE_SERVER]]];
    
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        return NO;
    }
    return YES;
}

- (void) disconnect
{
    isOpenStream = NO;
    [xmppStream disconnect];
}

- (void) xmppStreamDidConnect: (XMPPStream *) sender
{
    isOpenStream = YES;
    NSString *pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"pass"];
    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:pass error:&error];
}

- (void) xmppStream: (XMPPStream *) sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message elementForName:@"from"] stringValue];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:msg forKey:@"msg"];
    [dict setObject:from forKey:@"sender"];
    [dict setObject:[IMessageService getCurrentTime] forKey:@"time"];
    
    // -- 消息委托
    [messageReceiveDelegate messageReceive:dict];
}
@end
