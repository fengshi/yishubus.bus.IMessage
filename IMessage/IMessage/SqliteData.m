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
    
    const char *createMessageSql = "create table if not exists message (id integer primary key autoincrement,fid text,tid text,msg text,talktime text,isload integer)";
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
    } else {
        NSLog(@"数据库不存在");
    }
    
}

- (void) close
{
    sqlite3_close(db);
}
@end
