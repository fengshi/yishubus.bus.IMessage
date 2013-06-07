//
//  TeacherViewCellController.m
//  IMessage
//
//  Created by shi feng on 13-6-7.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "TeacherViewCellController.h"
#import "AddressBook.h"

@implementation TeacherViewCellController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initDraw:(AddressBook *)teacher
{
    self.headView.image = teacher.head;
    self.name.text = teacher.name;
    self.school.text = teacher.school;
}
@end
