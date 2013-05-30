//
//  LoginViewController.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userTextField;

@property (strong, nonatomic) IBOutlet UITextField *passTextField;

- (IBAction)loginAction:(id)sender;

@end
