//
//  IMSettingViewController.h
//  IMessage
//
//  Created by shi feng on 13-5-31.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tView;

@end
