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
#import "AddressBook.h"

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
//            [nid stringByAppendingString:OPEN_FILE_SERVER];

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
        NSDictionary *resultDirectionary = [jsonResult objectFromJSONString];
        if (![[resultDirectionary objectForKey:@"totalPage"] isEqual:@"0"]) {
            NSString *pageNumber = [resultDirectionary objectForKey:@"totalPage"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            [result addObject:pageNumber];
            NSArray *resultArray = [resultDirectionary objectForKey:@"items"];
            for (int i=0; i<[resultArray count]; i++) {
                NSDictionary *dictionary = [resultArray objectAtIndex:i];
                NSString *nid = [dictionary objectForKey:@"id"];

                NSString *sex = [dictionary objectForKey:@"sex"];
                UIImage *headPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dictionary objectForKey:@"photo"]]]];
                NSString *nickName = [dictionary objectForKey:@"nickName"];
                NSString *code = [dictionary objectForKey:@"email"];
                NSString *school = [dictionary objectForKey:@"infotxt"];
                
                AddressBook *teacher = [[AddressBook alloc] init];
                teacher.userId = nid;
                teacher.sex = sex;
                teacher.name = nickName;
                teacher.code = code;
                teacher.school = school;
                teacher.head = headPhoto;
                
                [result addObject:teacher];
            }
            return result;
        }
    }
    return nil;
}

+ (AddressBook *) userDetail:(NSString *)dataUrl userId:(NSString *)uid
{
    NSString *stringUrl = [NSString stringWithFormat:@"&id=%d",[uid intValue]];
    NSURL *url = [NSURL URLWithString:[dataUrl stringByAppendingString:stringUrl]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    AddressBook *book = [[AddressBook alloc]init];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSDictionary *dictionary = [jsonResult objectFromJSONString];
        NSString *code = [dictionary objectForKey:@"email"];
        UIImage *headPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dictionary objectForKey:@"photo"]]]];
        NSString *nickName = [dictionary objectForKey:@"nickName"];
        NSString *l2Names = [dictionary objectForKey:@"l2Names"];
        NSString *tutorWay = [dictionary objectForKey:@"tutorWay"];
        NSString *eduArea = [dictionary objectForKey:@"eduArea"];
        NSString *school = [dictionary objectForKey:@"school"];
        NSString *info = [dictionary objectForKey:@"info"];
        NSString *eduTag = [dictionary objectForKey:@"eduTag"];
        NSArray *imageUrls = [dictionary objectForKey:@"urls"];
        NSArray *awards = [dictionary objectForKey:@"awards"];
        
        book.userId = uid;
        book.name = nickName;
        book.code = code;
        book.head = headPhoto;
        book.label = l2Names;
        book.tutorWay = tutorWay;
        book.eduTag = eduTag;
        book.area = eduArea;
        book.school = school;
        book.info = info;
        book.awards = [[NSMutableArray alloc] initWithArray:awards];
        
        NSMutableArray *bookPics = [[NSMutableArray alloc] init];
        
        if (imageUrls.count > 0) {
            for (int i=0; i<imageUrls.count; i++) {
                NSDictionary *ihttp = [imageUrls objectAtIndex:i];
                UIImage *photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[ihttp objectForKey:@"url"]]]];
                [bookPics addObject:photo];
            }
        }
        book.pics = bookPics;
    }
    return book;
}
@end
