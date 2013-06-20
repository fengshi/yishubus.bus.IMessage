//
//  IMessageViewController.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMessageViewController.h"
#import "IMAddressBookController.h"
#import "IMSettingViewController.h"
#import "DejalActivityView.h"
#import "IMessageAppDelegate.h"
#import "FindLevelViewController.h"
#import "SqliteData.h"
#import "ShowMessageTableController.h"

@interface IMessageViewController ()

@end

@implementation IMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DejalBezelActivityView activityViewForView:[self appDelegate].window];    
    dispatch_queue_t queue = dispatch_queue_create("act", nil);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabBarController = [[UITabBarController alloc] init];
            [self.tabBarController.view setFrame:self.view.bounds];
            
            ShowMessageTableController *messageController = [[ShowMessageTableController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageController];
            messageNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
                
            IMAddressBookController *bookController = [[IMAddressBookController alloc] initWithNibName:@"IMAddressBookController" bundle:nil];
            UINavigationController *bookNav = [[UINavigationController alloc] initWithRootViewController:bookController];
            bookNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
                
            FindLevelViewController *levelController = [[FindLevelViewController alloc] init];
            UINavigationController *levelNav = [[UINavigationController alloc] initWithRootViewController:levelController];
            levelNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
                
            IMSettingViewController *settingController = [[IMSettingViewController alloc] initWithNibName:@"IMSettingViewController" bundle:nil];
            UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingController];
            settingNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
            
            self.tabBarController.viewControllers = [NSArray arrayWithObjects:messageNav,bookNav,levelNav,settingNav, nil];
                
            [self.view addSubview:self.tabBarController.view];
            [DejalBezelActivityView removeViewAnimated:YES];
        });
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IMessageAppDelegate *) appDelegate
{
    return (IMessageAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL) shouldAutorotate
{
    return NO;
}
@end
