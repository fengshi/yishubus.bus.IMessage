//
//  NetWorkData.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkData : NSObject

+ (BOOL) loginData:(NSString *)url email:(NSString *)mail password:(NSString *)pass;

@end
