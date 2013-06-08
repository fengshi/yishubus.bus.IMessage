//
//  RequestURL.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "RequestURL.h"
#import "Constants.h"

@implementation RequestURL

+ (NSString *) getUrlByKey:(NSInteger)key
{
    switch (key) {
        case LOGIN_URL:
            return [ACTION_MAIN stringByAppendingString:@"websitMoblieAction.do?action=login"];
        case LEVEL_URL:
            return [ACTION_MAIN stringByAppendingString:@"websitMoblieAction.do?action=level"];
        case TEACHER_URL:
            return [ACTION_MAIN stringByAppendingString:@"websitMoblieAction.do?action=find"];
        case USER_DETAIL_URL:
            return [ACTION_MAIN stringByAppendingString:@"websitMoblieAction.do?action=getDetail"];
        default:
            break;
    }
    return nil;
}

@end
