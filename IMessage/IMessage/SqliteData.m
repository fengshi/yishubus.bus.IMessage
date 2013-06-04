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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
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
    const char *createAddressBookSql = "create table if not exists addressbook (id integer primary key autoincrement,code text,name text,type int,label text,head text,area text,userid text)";
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
}

- (void) removeSqlite
{
    NSString *filePath = [self dbFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL find = [fileManager fileExistsAtPath:filePath];
    if (find) {
        NSLog(@"数据库存在");
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
