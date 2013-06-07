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
@property (nonatomic, strong) NSString *area;  // -- 授课地区
@property (nonatomic, strong) NSString *userId;// -- 用户ID
@property (nonatomic, strong) NSString *sex;   // -- 性别
@property (nonatomic, strong) NSString *info;  // -- 简介
@property (nonatomic, strong) NSString *school;// -- 毕业院校
@property (nonatomic, strong) NSString *tutorWay; // -- 授课方式
@property (nonatomic, strong) NSMutableArray *pics; // -- 图片集合
@property (nonatomic, strong) NSMutableArray *awards; // -- 荣誉集合
@property (nonatomic, strong) NSString *eduTag;   // -- 教学对象

@end
