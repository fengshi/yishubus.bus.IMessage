//
//  TalkMessageViewController.m
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "TalkMessageViewController.h"
#import "IMessageAppDelegate.h"

@interface TalkMessageViewController ()
{
    NSMutableArray *messageArray;
}
@end

@implementation TalkMessageViewController
@synthesize tView;
@synthesize textField;
@synthesize chatWithUser;

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
    self.tView.delegate = self;
    self.tView.dataSource = self;
    self.tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageArray = [NSMutableArray array];
    [textField becomeFirstResponder];
    
    IMessageAppDelegate *appDelegate = [self appDelegate];
    appDelegate.messageReceiveDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messageArray count];
}

- (IBAction)clickMessage:(id)sender {
}

- (void) messageReceive:(NSDictionary *)messageContent
{
    
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
