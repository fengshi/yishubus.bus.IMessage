//
//  TalkMessageViewController.h
//  IMessage
//
//  Created by shi feng on 13-6-8.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageReceiveDelegate.h"

@interface TalkMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MessageReceiveDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tView;

@property (strong, nonatomic) IBOutlet UITextField *myTextField;

-(void) setChatWithUser:(NSString *)userid;

- (IBAction)clickMessage:(id)sender;

@end