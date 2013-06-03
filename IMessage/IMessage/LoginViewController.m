//
//  LoginViewController.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "LoginViewController.h"
#import "IMessageService.h"
#import "IMessageViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    NSString *mail = self.userTextField.text;
    NSString *password = self.passTextField.text;
    
    IMessageService *service = [[IMessageService alloc] init];
//    BOOL isOrno = [service isLogin:mail password:password];
    BOOL isOrno = YES;
    if (isOrno) {
        IMessageViewController *con = [[IMessageViewController alloc] init];
        self.view.window.rootViewController = con;
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败!" message:@"用户名或密码输入错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end
