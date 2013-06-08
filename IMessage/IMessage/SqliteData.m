//
//  SqliteData.m
//  IMessage
//
//  Created by shi feng on 13-6-4.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "SqliteData.h"
#import "Constants.h"

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
    const char *createAddressBookSql = "create table if not exists addressbook (id integer primary key autoincrement,code text,name text,type integer,label text,head blob,area text,userid text,school text,info text,tutorway text,edutag text)";
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
