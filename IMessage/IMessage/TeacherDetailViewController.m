//
//  TeacherDetailViewController.m
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "TeacherDetailViewController.h"
#import "Constants.h"
#import "NetWorkData.h"
#import "AddressBook.h"
#import "RequestURL.h"
#import "DejalActivityView.h"
#import "IMessageAppDelegate.h"
#import "SqliteData.h"

@interface TeacherDetailViewController ()
{
    AddressBook *teacher;
}
@end

@implementation TeacherDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
    SqliteData *util = [[SqliteData alloc] init];
    BOOL isFriend = [util isFriend:teacher.userId];
    if (!isFriend) {
        [util addFriend:teacher];
    }
    
}

- (void) initDraw: (NSString *)uid
{
    
    [DejalBezelActivityView activityViewForView:[self appDelegate].window];
    dispatch_queue_t queue = dispatch_queue_create("detailqueue", nil);
    dispatch_async(queue, ^{
        NSString *stringUrl = [RequestURL getUrlByKey:USER_DETAIL_URL];
        teacher = [NetWorkData userDetail:stringUrl userId:uid];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headView.image = teacher.head;
            self.name.text = teacher.name;
            self.school.text = teacher.school;
            self.typeLabel.text = teacher.label;
            self.tutorWay.text = teacher.tutorWay;
            self.info.text = teacher.info;

            [DejalBezelActivityView removeView];
        });
    });

}

- (IMessageAppDelegate *) appDelegate
{
    return (IMessageAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
