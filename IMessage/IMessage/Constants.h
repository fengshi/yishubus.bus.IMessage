//
//  Constants.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

typedef enum _NSUserType
{
    UserTypeTeacher = 2,
    UserTypeUser = 1
} NSUserType;

#define OPEN_FILE_SERVER @"@yishubus"
#define ACTION_MAIN      @"http://www.yishubus.com/"
#define XMPP_MAIN        @"www.yishubus.com"
#define DB_NAME          @"message.sqlite"

#define LOGIN_URL        1
#define LEVEL_URL        2
#define TEACHER_URL      3
#define USER_DETAIL_URL  4
#define SAVE_MESSAGE     5