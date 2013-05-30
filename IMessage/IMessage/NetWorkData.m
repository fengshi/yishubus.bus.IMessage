//
//  NetWorkData.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "NetWorkData.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"

@implementation NetWorkData

+ (BOOL) loginData:(NSString *)url email:(NSString *)mail password:(NSString *)pass
{
    NSString *stringUrl = [NSString stringWithFormat:@"&email=%@&password=%@",mail,pass];
    
    NSURL *netUrl = [NSURL URLWithString:[url stringByAppendingString:stringUrl]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:netUrl];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        
        NSDictionary *resultDictionary = [jsonResult objectFromJSONString];
        NSString *code = [resultDictionary objectForKey:@"code"];
        if ([code isEqualToString:@"ok"]) {
            NSString *nickName = [resultDictionary objectForKey:@"nickName"];
            NSString *nid = [resultDictionary objectForKey:@"id"];
            NSString *type = [resultDictionary objectForKey:@"type"];
            NSString *photo = [resultDictionary objectForKey:@"photo"];
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo]];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:mail forKey:@"mail"];
            [defaults setObject:pass forKey:@"pass"];
            [defaults setObject:nid forKey:@"id"];
            [defaults setObject:nickName forKey:@"nickName"];
            [defaults setObject:type forKey:@"type"];
            [defaults setObject:imageData forKey:@"headPhoto"];
            
            //            [defaults synchronize];
            return YES;
        }
    }
    return NO;
}

@end
