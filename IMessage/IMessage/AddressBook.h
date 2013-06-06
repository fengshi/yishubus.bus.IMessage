//
//  AddressBook.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface AddressBook : NSObject

@property (nonatomic, strong) NSString *code;  // -- 用户名
@property (nonatomic, strong) NSString *name;  // -- 妮称
@property (nonatomic) NSUserType type;         // -- 用户类型(教师,用户)
@property (nonatomic, strong) NSString *label; // -- 艺术种类,如钢琴,小提琴 (只有教师有此内容)
@property (nonatomic, strong) UIImage *head;   // -- 头像
@property (nonatomic, strong) NSString *area;  // -- 地区
@property (nonatomic, strong) NSString *userId;// -- openfire用户名(组合好的)
@property (nonatomic, strong) NSString *sex;   // -- 性别
@property (nonatomic, strong) NSString *info;  // -- 简介

@end
