//
//  TeacherViewController.m
//  IMessage
//
//  Created by shi feng on 13-6-7.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "TeacherViewController.h"
#import "RequestURL.h"
#import "Constants.h"
#import "NetWorkData.h"
#import "DejalActivityView.h"
#import "IMessageAppDelegate.h"
#import "AddressBook.h"
#import "TeacherViewCellController.h"

@interface TeacherViewController ()
{
    NSMutableArray *result;
    NSInteger page;
    BOOL isLoading;
    NSString *lidString;
}
@end

@implementation TeacherViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initLid:(NSString *)lid lName:(NSString *)name
{
    lidString = lid;
    self.navigationItem.title = [name stringByAppendingString:@"老师"];
    
    [self loadData];
}

- (void) turnPage: (NSString *) lid
{
    if (!isLoading) {
        isLoading = YES;
        page = page + 1;
        
        [DejalBezelActivityView activityViewForView:[self appDelegate].window];
        dispatch_queue_t queue = dispatch_queue_create("act", nil);
        dispatch_async(queue, ^{
            NSString *stringUrl = [RequestURL getUrlByKey:TEACHER_URL];
            NSMutableArray *data = [NetWorkData searchTeacher:stringUrl page:[NSString stringWithFormat:@"%d",page] lt:@"2" lid:lid];
            if ([data count] > 0) {
                for (int i=0; i<[data count]; i++) {
                    [result addObject:[data objectAtIndex:i]];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                isLoading = NO;
                [DejalBezelActivityView removeView];
            });
        });
    }
}

- (void) loadData
{
    page = 0;
    isLoading = NO;
    result = [[NSMutableArray alloc] init];
    [self turnPage:lidString];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    static NSString *CellIdentifier = @"tcell";
    UINib *nib = [UINib nibWithNibName:@"TeacherViewCellController" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    TeacherViewCellController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    AddressBook *teacher = [result objectAtIndex:indexPath.row];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IMessageAppDelegate *)appDelegate
{
    return (IMessageAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 10;
    if (y > h + reload_distance) {
        [self turnPage:lidString];
    }
}
@end
