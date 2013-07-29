//
//  TeacherDetailViewController.h
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *headView;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *school;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *tutorWay;

@property (strong, nonatomic) IBOutlet UILabel *area;

@property (strong, nonatomic) IBOutlet UILabel *info;

@property (strong, nonatomic) IBOutlet UIButton *phoneButton;

- (IBAction)sendMessage:(id)sender;

- (void) initDraw: (NSString *)uid;
@end
