//
//  IMessageViewController.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMessageViewController.h"
#import "ShowMessageViewController.h"
#import "IMAddressBookController.h"

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
	self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController.view setFrame:self.view.bounds];
    
    ShowMessageViewController *messageController = [[ShowMessageViewController alloc] initWithNibName:@"ShowMessageViewController" bundle:nil];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageController];
    messageNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
    
    IMAddressBookController *bookController = [[IMAddressBookController alloc] initWithNibName:@"IMAddressBookController" bundle:nil];
    UINavigationController *bookNav = [[UINavigationController alloc] initWithRootViewController:bookController];
    bookNav.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:messageNav,bookNav, nil];
    
    [self.view addSubview:self.tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return NO;
}
@end
