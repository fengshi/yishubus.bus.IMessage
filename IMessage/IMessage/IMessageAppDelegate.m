//
//  IMessageAppDelegate.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMessageAppDelegate.h"
#import "IMessageViewController.h"
#import "Constants.h"
#import "IMessageService.h"
#import "SqliteData.h"
#import "RequestURL.h"
#import "AddressBook.h"
#import "NetWorkData.h"

@implementation IMessageAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    IMessageViewController *con = [[IMessageViewController alloc] init];
    self.window.rootViewController = con;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    startImageView = [[UIImageView alloc] initWithFrame:self.window.frame];
    startImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]];
    
    [self.window addSubview:startImageView];
    [self performSelector:@selector(theAnimation) withObject:nil afterDelay:3];
    
    return YES;
}

- (void) theAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        startImageView.frame = CGRectMake(self.window.frame.origin.x, self.window.frame.size.height, -self.window.frame.size.width, -self.window.frame.size.height);
    }];
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
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
@end
