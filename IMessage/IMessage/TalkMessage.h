//
//  TalkMessage.h
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkMessage : NSObject

@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) UIImage *fromHeadImage;
@property (nonatomic, strong) UIImage *toHeadImage;
@property (nonatomic, strong) UIImage *fromBack;
@property (nonatomic, strong) UIImage *toBack;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *talkTime;
@property (nonatomic) float height;

@end
