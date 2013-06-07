//
//  TeacherViewCellController.h
//  IMessage
//
//  Created by shi feng on 13-6-7.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressBook;
@interface TeacherViewCellController : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *school;

- (void) initDraw:(AddressBook *)teacher;
@end