//
//  ShowMessageTableController.m
//  IMessage
//
//  Created by shi feng on 13-6-18.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "ShowMessageTableController.h"
#import "IMessageService.h"
#import "ShowMessageCell.h"
#import "TalkMessageViewController.h"
#import "IMessageAppDelegate.h"
#import "SqliteData.h"
#import <AudioToolbox/AudioToolbox.h>


@interface ShowMessageTableController ()
{
    SystemSoundID soundID;
}
@end

@implementation ShowMessageTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"消息";
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"消息" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1_2" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1_1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    IMessageAppDelegate *appDelegate = [self appDelegate];
    appDelegate.messageReceiveDelegate = self;
    
    NSURL *musicPath = [[NSBundle mainBundle] URLForResource:@"1317" withExtension:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)musicPath, &soundID);
}

- (void) loadArrays
{
    dispatch_queue_t downloadArray = dispatch_queue_create("mainArray2", nil);
    dispatch_async(downloadArray, ^{
        IMessageService *util = [[IMessageService alloc] init];
        self.messageArray = [util showMessageInitLoadFriends];

        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0; i<self.messageArray.count; i++) {
                NSMutableDictionary *dd = [self.messageArray objectAtIndex:i];
                NSNumber *unload = [dd objectForKey:@"unload"];
                if (unload.intValue > 0) {
                    AudioServicesPlaySystemSound(soundID);
                    break;
                }
            }
            [self.tableView reloadData];
        });
    });
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadArrays];
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
    return [self.messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"showMessageCell";
    UINib *nib = [UINib nibWithNibName:@"ShowMessageCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    ShowMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableDictionary *dire = [self.messageArray objectAtIndex:indexPath.row];
    [cell initDraw:dire];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *dire = [self.messageArray objectAtIndex:indexPath.row];
        NSString *userid = [dire objectForKey:@"userid"];
        SqliteData *util = [[SqliteData alloc] init];
        [util deleteFriendMessages:userid];
        
        [self.messageArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dire = [self.messageArray objectAtIndex:indexPath.row];
    
    TalkMessageViewController *talkController = [[TalkMessageViewController alloc] init];
    [talkController setChatWithUser:[dire objectForKey:@"userid"]];
    [self.navigationController pushViewController:talkController animated:YES];
}

- (void) messageReceive:(NSDictionary *)messageContent
{
    NSString *fid = [messageContent objectForKey:@"sender"];
    NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *talkTime = [IMessageService getCurrentTime];
    SqliteData *util = [[SqliteData alloc] init];
    
    [util addMessage:mid fromid:fid toid:mid talkMessage:[messageContent objectForKey:@"msg"] talkTime:talkTime load:1 userid:fid];
    
    [self loadArrays];
}

- (IMessageAppDelegate *) appDelegate
{
    return (IMessageAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *) xmppStream
{
    return [[self appDelegate] xmppStream];
}
@end
