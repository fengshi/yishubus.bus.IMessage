//
//  IMAddressBookController.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMAddressBookController.h"
#import "AddressBook.h"
#import "SqliteData.h"
#import "TeacherViewCellController.h"
#import "TeacherDetailViewController.h"

@interface IMAddressBookController ()
{
    NSMutableArray *datas;
}
@end

@implementation IMAddressBookController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"通讯录";
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar2_2" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar2_1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tView.delegate = self;
    self.tView.dataSource = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    SqliteData *util = [[SqliteData alloc] init];
    datas = [util myFriends];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tcell";
    UINib *nib = [UINib nibWithNibName:@"TeacherViewCellController" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    TeacherViewCellController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    AddressBook *teacher = [datas objectAtIndex:indexPath.row];
    [cell initDraw:teacher];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressBook *teacher = [datas objectAtIndex:indexPath.row];
    TeacherDetailViewController *teacherDetail = [[TeacherDetailViewController alloc] init];
    [teacherDetail initDraw:teacher.userId];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:teacherDetail animated:YES];
}
@end
