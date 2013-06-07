//
//  FindLevelDetailViewController.m
//  IMessage
//
//  Created by shi feng on 13-6-6.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "FindLevelDetailViewController.h"
#import "FindLevel.h"
#import "TeacherViewController.h"

@interface FindLevelDetailViewController ()
{
    NSMutableArray *array;
}
@end

@implementation FindLevelDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initData:(NSMutableArray *)data titleName:(NSString *)name
{
    array = data;
    self.navigationItem.title = name;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    array = [[NSMutableArray alloc] init];
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
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    FindLevel *detailLevel = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = detailLevel.lName;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindLevel *level = [array objectAtIndex:indexPath.row];
    TeacherViewController *teacher = [[TeacherViewController alloc] init];
    [teacher initLid:level.lid lName:level.lName];
    [self.navigationController pushViewController:teacher animated:YES];
}

@end
