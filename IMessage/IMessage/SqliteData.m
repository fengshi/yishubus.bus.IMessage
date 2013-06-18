//
//  SqliteData.m
//  IMessage
//
//  Created by shi feng on 13-6-4.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "SqliteData.h"
#import "Constants.h"
#import "AddressBook.h"

@implementation SqliteData
@synthesize db = _db;

- (NSString *)dbFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:DB_NAME];
}

- (BOOL)open
{

    NSString *path = [self dbFilePath];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }
    // -- 初始化表
    [self initCreateTable];
    return YES;
}

- (void) initCreateTable
{
    const char *createAddressBookSql = "create table if not exists addressbook (id integer primary key autoincrement,code text,name text,type integer,label text,head blob,area text,userid text,school text,info text,tutorway text,edutag text,mid text)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, createAddressBookSql, -1, &statement, nil) != SQLITE_OK) {
        UIAlertView *showView = [[UIAlertView alloc] initWithTitle:@"初始化通讯录" message:@"解析建表语句失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [showView show];
    }
    
    if (sqlite3_step(statement) != SQLITE_DONE) {
        UIAlertView *showView = [[UIAlertView alloc] initWithTitle:@"初始化通讯录" message:@"建表失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [showView show];
    }
    sqlite3_finalize(statement);
    
    const char *createMessageSql = "create table if not exists message (id integer primary key autoincrement,fid text,tid text,msg text,talktime text,isload integer,mid text,userid text)";
    if (sqlite3_prepare_v2(db, createMessageSql, -1, &statement, nil) != SQLITE_OK) {
        UIAlertView *showView = [[UIAlertView alloc] initWithTitle:@"初始化聊天" message:@"解析建表语句失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [showView show];
    }
    
    if (sqlite3_step(statement) != SQLITE_DONE) {
        UIAlertView *showView = [[UIAlertView alloc] initWithTitle:@"初始化聊天" message:@"建表失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [showView show];
    }
    sqlite3_finalize(statement);
}

- (BOOL) addFriend:(AddressBook *) friendBook
{
    if ([self open]) {
        const char *sql = "insert into addressbook (code,name,type,label,head,area,userid,school,info,tutorway,edutag,mid) values(?,?,?,?,?,?,?,?,?,?,?,?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
            NSData *headData = UIImagePNGRepresentation(friendBook.head);
            NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
            
            sqlite3_bind_text(statement, 1, [friendBook.code UTF8String], -1, nil);
            sqlite3_bind_text(statement, 2, [friendBook.name UTF8String], -1, nil);
            sqlite3_bind_int(statement, 3, 2);
            sqlite3_bind_text(statement, 4, [friendBook.label UTF8String], -1, nil);
            sqlite3_bind_blob(statement, 5, [headData bytes], [headData length], nil);
            sqlite3_bind_text(statement, 6, [friendBook.area UTF8String], -1, nil);
            sqlite3_bind_text(statement, 7, [friendBook.userId UTF8String], -1, nil);
            sqlite3_bind_text(statement, 8, [friendBook.school UTF8String], -1, nil);
            sqlite3_bind_text(statement, 9, [friendBook.info UTF8String], -1, nil);
            sqlite3_bind_text(statement, 10, [friendBook.tutorWay UTF8String], -1, nil);
            sqlite3_bind_text(statement, 11, [friendBook.eduTag UTF8String], -1, nil);
            sqlite3_bind_text(statement, 12, [mid UTF8String], -1, nil);
            
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"通讯录添加失败!");
                return NO;
            }
        }
        sqlite3_finalize(statement);
        [self close];
    }
    return YES;
}

- (void) addMessage:(NSString *)mid fromid:(NSString *)fid toid:(NSString *)tid talkMessage:(NSString *)msg talkTime:(NSString *)time load:(int)isload userid:(NSString *)userid
{
    if ([self open]) {
        char *errormsg;
        
        NSString *sql = [NSString stringWithFormat:@"insert into message (fid,tid,msg,talktime,isload,mid,userid) values('%@','%@','%@','%@',%d,'%@','%@')",fid,tid,msg,time,isload,mid,userid];
        if (sqlite3_exec(db, [sql UTF8String], nil, nil, &errormsg) == SQLITE_OK) {
        }
        [self close];
    }
}

- (BOOL) isFriend:(NSString *)uid
{
    if ([self open]) {
        NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        NSString *sql = [NSString stringWithFormat:@"select id from addressbook where mid='%@' and userid='%@'",mid,uid];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                return YES;
            }
        }
        sqlite3_finalize(statement);
        [self close];
    }
    return NO;
}

- (AddressBook *) getFriend:(NSString *)uid
{
    AddressBook *friend = [[AddressBook alloc] init];
    if ([self open]) {
        NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        NSString *sql = @"select * from addressbook where mid = ? and userid = ?";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [mid UTF8String], -1, nil);
            sqlite3_bind_text(statement, 2, [uid UTF8String], -1, nil);
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *code = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                int type = sqlite3_column_int(statement, 3);
                NSString *label = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                int headBytes = sqlite3_column_bytes(statement, 5);
                NSData *head = [NSData dataWithBytes:sqlite3_column_blob(statement, 5) length:headBytes];
                UIImage *headImage = [UIImage imageWithData:head];
                NSString *area = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                NSString *school = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                NSString *info = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                NSString *tutorway = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                NSString *edutag = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                
                friend.code = code;
                friend.name = name;
                friend.head = headImage;
                friend.label = label;
                friend.type = type;
                friend.area = area;
                friend.userId = uid;
                friend.school = school;
                friend.info = info;
                friend.tutorWay = tutorway;
                friend.eduTag = edutag;
            }
        }
        sqlite3_finalize(statement);
        [self close];
    }
    return friend;
}

- (NSMutableArray *) bookMessage
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if ([self open]) {
        NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        // -- find my all friends
        NSString *sql = @"select userid from message where mid = ? group by userid";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [mid UTF8String], -1, nil);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *userid = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSMutableDictionary *friendMessageDirectionary = [[NSMutableDictionary alloc] init];
                [friendMessageDirectionary setObject:userid forKey:@"userid"];
                [result addObject:friendMessageDirectionary];
            }
        }
        sqlite3_finalize(statement);
        // -- count friend all unload message number
        for (int i=0; i<result.count; i++) {
            NSMutableDictionary *friendMessageDirectionary = [result objectAtIndex:i];
            NSString *userid = [friendMessageDirectionary objectForKey:@"userid"];
            sql = @"select count(*) from message where mid = ? and userid = ? and isload = ?";
            if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
                sqlite3_bind_text(statement, 1, [mid UTF8String], -1, nil);
                sqlite3_bind_text(statement, 2, [userid UTF8String], -1, nil);
                sqlite3_bind_int(statement, 3, 1);
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    int unloadNumber = sqlite3_column_int(statement, 0);
                    [friendMessageDirectionary setObject:[NSNumber numberWithInt:unloadNumber] forKey:@"unload"];
                }
            }
            sqlite3_finalize(statement);
        }
        // -- find friend message last on
        for (int i=0; i<result.count; i++) {
            NSMutableDictionary *friendMessageDirectionary = [result objectAtIndex:i];
            NSString *userid = [friendMessageDirectionary objectForKey:@"userid"];
            sql = @"select msg,talktime from message where mid = ? and userid = ? order by id desc limit 1 offset 0";
            if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
                sqlite3_bind_text(statement, 1, [mid UTF8String], -1, nil);
                sqlite3_bind_text(statement, 2, [userid UTF8String], -1, nil);
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *lastMsg = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    NSString *talktime = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    [friendMessageDirectionary setObject:lastMsg forKey:@"msg"];
                    [friendMessageDirectionary setObject:talktime forKey:@"time"];
                }
            }
            sqlite3_finalize(statement);
        }
        [self close];
    }
    return result;
}

- (BOOL) updateFriendIsLoad:(NSString *)uid
{
    if ([self open]) {
        char *errormsg;
        NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        NSString *sql = [NSString stringWithFormat:@"update message set isload = 2 where mid = '%@' and userid = '%@'",mid,uid];
        if (sqlite3_exec(db, [sql UTF8String], nil, nil, &errormsg) == SQLITE_OK) {
            [self close];
            return YES;
        }
        [self close];
    }
    return NO;
}

- (void) removeSqlite
{
    if ([self open]) {
        [self close];
    }
    NSString *filePath = [self dbFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL find = [fileManager fileExistsAtPath:filePath];
    if (find) {
        [fileManager removeItemAtPath:filePath error:nil];
        NSLog(@"数据库已删除");
    } else {
        NSLog(@"数据库不存在");
    }
    
}

- (void) close
{
    sqlite3_close(db);
}
@end
