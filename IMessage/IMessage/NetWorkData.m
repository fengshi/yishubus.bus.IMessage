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
#import "Constants.h"
#import "FindLevel.h"

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
            [nid stringByAppendingString:OPEN_FILE_SERVER];
            NSLog(@"%@",nid);
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
            
            [defaults synchronize];
            return YES;
        }
    }
    return NO;
}

+ (NSMutableArray *) loginLevel: (NSString *)dataUrl
{
    NSURL *url = [NSURL URLWithString:dataUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int i=0; i<[resultArray count]; i++) {
            NSDictionary *data = [resultArray objectAtIndex:i];
            NSString *lid = [data objectForKey:@"id"];
            NSString *lName = [data objectForKey:@"name"];
            NSArray *detailData = [data objectForKey:@"items"];
            FindLevel *find = [[FindLevel alloc] init];
            find.lid = lid;
            find.lName = lName;
            NSMutableArray *detailArray = [[NSMutableArray alloc] init];
            if ([detailData count] > 0) {
                for (int ii=0; ii<[detailData count]; ii++) {
                    NSDictionary *detailDict = [detailData objectAtIndex:ii];
                    NSString *detailLid = [detailDict objectForKey:@"id"];
                    NSString *detaillName = [detailDict objectForKey:@"name"];
                    FindLevel *detailFind = [[FindLevel alloc] init];
                    detailFind.lid = detailLid;
                    detailFind.lName = detaillName;
                    [detailArray addObject:detailFind];
                }
            }
            find.detailLevel = detailArray;
            [result addObject:find];
        }
        return result;
    }
    return nil;
}

+ (NSMutableArray *) searchTeacher:(NSString *)dataUrl page:(NSString *)page lt:(NSString *)lt lid:(NSString *)lid
{
    NSString *stringUrl = [NSString stringWithFormat:@"&page=%@&lt=%@&lid=%@",page,lt,lid];
    
    NSURL *netUrl = [NSURL URLWithString:[dataUrl stringByAppendingString:stringUrl]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:netUrl];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        if ([resultArray count] > 0) {
            NSMutableArray *result = [[NSMutableArray alloc] init];
            return result;
        }
    }
    return nil;
}
@end
