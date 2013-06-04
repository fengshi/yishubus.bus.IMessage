//
//  SqliteData.h
//  IMessage
//
//  Created by shi feng on 13-6-4.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteData : NSObject
{
    sqlite3 *db;
}

@property (nonatomic) sqlite3 *db;

- (BOOL) open;
- (void) close;

@end