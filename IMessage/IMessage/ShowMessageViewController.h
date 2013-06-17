//
//  ShowMessageViewController.h
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ShowMessageViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tView;
- (void) initDraw: (NSMutableArray *) array;

@end
