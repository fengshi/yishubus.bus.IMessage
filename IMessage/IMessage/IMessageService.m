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
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [formatter stringFromDate:nowUTC];
}
@end
