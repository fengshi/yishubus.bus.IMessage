//
//  IMessageService.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "IMessageService.h"
#import "NetWorkData.h"
#import "RequestURL.h"
#import "Constants.h"
#import "SqliteData.h"
#import "AddressBook.h"

@implementation IMessageService

- (void) removeLoginMessage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"mail"];
    [defaults removeObjectForKey:@"pass"];
    [defaults removeObjectForKey:@"id"];
    [defaults removeObjectForKey:@"nickName"];
    [defaults removeObjectForKey:@"type"];
    [defaults removeObjectForKey:@"headPhoto"];
}

- (BOOL) isLogin:(NSString *)email password:(NSString *)pass
{
    // -- 登录验证前删除本地登录内容
    [self removeLoginMessage];
    
    BOOL yesorno = [NetWorkData loginData:[RequestURL getUrlByKey:LOGIN_URL] email:email password:pass];
    return yesorno;
}

+ (NSString *) getCurrentTime
{
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone localTimeZone]];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [formatter setDateFormat:@"yyyy年MM月dd日#EEEE"]; // EEEE为星期几,EEE为周几
//    [formatter setDateFormat:@"yyyy年MMMMd日"]; // MMMM为XX月,d可以省去01日前的0
    
    return [formatter stringFromDate:nowUTC];
}

+ (NSString *) getWeek
{
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"#EEEE"];
    
    return [formatter stringFromDate:nowUTC];
}

- (NSMutableArray *) showMessageInitLoadFriends
{
    SqliteData *util = [[SqliteData alloc] init];
    NSMutableArray *array = [util bookMessage];
    for (int i = 0; i < array.count; i++) {
        NSMutableDictionary *directionary = [array objectAtIndex:i];
        NSString *userid = [directionary objectForKey:@"userid"];
        // -- 判断此联系人是否在通讯录中,如果不在,则加为好友
        BOOL isfriend = [util isFriend:userid];
        AddressBook *book = [[AddressBook alloc]init];
        if (!isfriend) {
            NSString *stringUrl = [RequestURL getUrlByKey:USER_DETAIL_URL];
            book = [NetWorkData userDetail:stringUrl userId:userid];
            [util addFriend:book];
        } else {
            book = [util getFriend:userid];
        }

        [directionary setObject:book.head forKey:@"head"];
        [directionary setObject:book.name forKey:@"name"];
    }
    return array;
}
@end
