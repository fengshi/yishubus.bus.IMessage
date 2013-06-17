//
//  IMessageService.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMessageService : NSObject

+ (NSString *) getCurrentTime;
+ (NSString *) getWeek;
- (void) removeLoginMessage;
- (BOOL) isLogin:(NSString *)email password:(NSString *)pass;
- (NSMutableArray *) showMessageInitLoadFriends;
@end