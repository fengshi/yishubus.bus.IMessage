//
//  NetWorkData.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressBook;
@interface NetWorkData : NSObject

+ (BOOL) loginData:(NSString *)url email:(NSString *)mail password:(NSString *)pass;
+ (NSMutableArray *) loginLevel: (NSString *)dataUrl;
+ (NSMutableArray *) searchTeacher:(NSString *)dataUrl page:(NSString *)page lt:(NSString *)lt lid:(NSString *)lid;
+ (AddressBook *) userDetail:(NSString *)dataUrl userId:(NSString *)uid;
+ (void) addMessage:(NSString *)mid toUser:(NSString *)uid sendDate:(NSString *)talkTime msgtype:(NSString *)type msg:(NSString *)msg url:(NSString *)dataUrl;
@end
