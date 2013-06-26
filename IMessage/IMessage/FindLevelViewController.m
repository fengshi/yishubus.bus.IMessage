//
//  FindLevelViewController.m
//  IMessage
//
//  Created by shi feng on 13-6-6.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "FindLevelViewController.h"
#import "NetWorkData.h"
#import "RequestURL.h"
#import "Constants.h"
#import "FindLevel.h"
#import "FindLevelDetailViewController.h"

@interface FindLevelViewController ()
{
    NSMutableArray *result;
    BOOL isLoading;
}
@end

@implementation FindLevelViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"找老师";
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"找老师" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar3_2" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar3_1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isLoading = NO;
    NSString *url = [RequestURL getUrlByKey:LEVEL_URL];
    result = [NetWorkData loginLevel:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    FindLevel *level = [result objectAtIndex:indexPath.row];
    cell.textLabel.text = level.lName;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindLevel *level = [result objectAtIndex:indexPath.row];
    FindLevelDetailViewController *detailController = [[FindLevelDetailViewController alloc] init];
    [detailController initData:level.detailLevel titleName:level.lName];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
