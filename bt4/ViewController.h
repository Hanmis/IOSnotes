//
//  ViewController.h
//  BT4
//
//  Created by Cliff on 12-9-26.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "LeDiscovery.h"
#import "LeService.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LeDiscoveryDelegate, UITextViewDelegate, LeServiceProtocol>

@property (retain, nonatomic) IBOutlet UITableView * tableView;
@property (retain, nonatomic) IBOutlet UITextView *logView;

- (IBAction)scanAction:(id)sender;
- (IBAction)stopScan:(id)sender;
- (IBAction)refreshTableView:(id)sender;

@end
