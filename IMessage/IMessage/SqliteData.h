//
//  SqliteData.h
//  IMessage
//
//  Created by shi feng on 13-6-4.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class AddressBook;
@interface SqliteData : NSObject
{
    sqlite3 *db;
}

@property (nonatomic) sqlite3 *db;

- (BOOL) open;
- (void) close;
- (void) removeSqlite;
- (BOOL) isFriend:(NSString *)uid;
- (BOOL) addFriend:(AddressBook *) friendBook;
- (NSMutableArray *) bookMessage;
- (AddressBook *) getFriend:(NSString *)uid;
- (BOOL) updateFriendIsLoad:(NSString *)uid;
- (void) addMessage:(NSString *)mid fromid:(NSString *)fid toid:(NSString *)tid talkMessage:(NSString *)msg talkTime:(NSString *)time load:(int)isload userid:(NSString *)userid;
- (NSMutableArray *) friendAllMessages:(NSString *)uid;
- (BOOL) deleteFriendMessages:(NSString *)uid;
- (NSMutableArray *) myFriends;

@end