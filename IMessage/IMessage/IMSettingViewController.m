//
//  IMSettingViewController.m
//  IMessage
//
//  Created by shi feng on 13-5-31.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMSettingViewController.h"
#import "LoginViewController.h"
#import "IMessageService.h"

@interface IMSettingViewController ()
{
    NSArray *array;
}

@end

@implementation IMSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"设置";
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"设置" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar4_2" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar4_1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [defaults objectForKey:@"mail"];
    NSString *name = [defaults objectForKey:@"nickName"];
    UIImage *head = [UIImage imageWithData:[defaults objectForKey:@"headPhoto"]];
    array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"昵称:%@",name],[NSString stringWithFormat:@"用户名:%@",mail], nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return [array count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idef = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idef];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idef];
    }
    
    if (indexPath.section == 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [button setFrame:CGRectMake(0, 0, 300, cell.frame.size.height)];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    } else {
        cell.userInteractionEnabled = NO;
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
    }
    return cell;
}

- (void) buttonClick
{
    IMessageService *service = [[IMessageService alloc] init];
    [service removeLoginMessage];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:^(void){}];
}
@end
