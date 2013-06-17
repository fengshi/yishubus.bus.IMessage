//
//  ShowMessageViewController.m
//  IMessage
//
//  Created by shi feng on 13-5-30.
//  Copyright (c) 2013年 yishubus. All rights reserved.
//

#import "ShowMessageViewController.h"

@interface ShowMessageViewController ()
{
    NSMutableArray *result;
}

@end

@implementation ShowMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"消息";
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"消息" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

-(void) initDraw:(NSMutableArray *)array
{
    self.tView.dataSource = self;
    self.tView.delegate = self;
    result = array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationManager *location = [[CLLocationManager alloc] init];
    location.distanceFilter = 500.0f;
    location.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    location.delegate = self;
    
    [location startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations != nil) {
        if ([locations count] == 2) {
            CLLocation *nowLocation = [locations objectAtIndex:1];
            NSString *lat = [[NSString alloc] initWithFormat:@"%g",nowLocation.coordinate.latitude];
            NSString *lng = [[NSString alloc] initWithFormat:@"%g",nowLocation.coordinate.longitude];
            
            [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"latitude"];
            [[NSUserDefaults standardUserDefaults] setObject:lng forKey:@"longitude"];
            
        } else {
            
            CLLocation *nowLocation = [locations objectAtIndex:0];
            NSString *lat = [[NSString alloc] initWithFormat:@"%g",nowLocation.coordinate.latitude];
            NSString *lng = [[NSString alloc] initWithFormat:@"%g",nowLocation.coordinate.longitude];
            
            [[NSUserDefaults standardUserDefaults] setObject:lat forKey:@"latitude"];
            [[NSUserDefaults standardUserDefaults] setObject:lng forKey:@"longitude"];
            
        }
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return result.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"showMessageCell";
    UINib *nib = [UINib nibWithNibName:@"ShowMessageCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
}
@end
