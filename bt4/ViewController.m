//
//  ViewController.m
//  BT4
//
//  Created by Cliff on 12-9-26.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - UITableViewDataSource
@synthesize tableView = _tableView;

//设置tableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    	NSInteger count = [[[LeDiscovery sharedInstance] foundPeripherals] count];

	if (count == 0)
		count = [[[LeDiscovery sharedInstance] connectedServices] count];
	return count;
}
//这个方法返回的cell代表每一行显示的内容，每显示一行都会运行一次此方法。
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	UITableViewCell	*cell;
	CBPeripheral	*peripheral;
	NSArray		*devices;
	NSInteger row = [indexPath row];
        static NSString *cellID = @"DeviceList";
    	//设置UITableView的id
	cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	//寻找已经加上自定义标注的当前可用的cell
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
    
	if ([[LeDiscovery sharedInstance] connectedServices]==nil) {
		devices = [[LeDiscovery sharedInstance] connectedServices];
        	peripheral = [(LeService*)[devices objectAtIndex:row] peripheral];
        
	} else {
        
		devices = [[LeDiscovery sharedInstance] foundPeripherals];
        	peripheral = (CBPeripheral*)[devices objectAtIndex:row];
	}
    
        if ([[peripheral name] length])
        	[[cell textLabel] setText:[peripheral name]];
        else
        	[[cell textLabel] setText:@"Peripheral"];
    
    	[[cell detailTextLabel] setText: [peripheral isConnected] ? @"Connected" : @"Not connected"];
    
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        CBPeripheral *peripheral;
	NSArray	 *devices;
	NSInteger row = [indexPath row];
	
	if ([[LeDiscovery sharedInstance] connectedServices] == nil)
    	{
		devices = [[LeDiscovery sharedInstance] connectedServices];
        	peripheral = [(LeService*)[devices objectAtIndex:row] peripheral];
	} else {
		devices = [[LeDiscovery sharedInstance] foundPeripherals];
    		peripheral = (CBPeripheral*)[devices objectAtIndex:row];
	}
    
	if (![peripheral isConnected])
    	{
		[[LeDiscovery sharedInstance] connectPeripheral:peripheral];
    	} else {
		[[LeDiscovery sharedInstance] disconnectPeripheral:peripheral];
    	}
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}

#pragma mark - viewLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[LeDiscovery sharedInstance] setDiscoveryDelegate:self];
    [[LeDiscovery sharedInstance] setPeripheralDelegate:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackgroundNotification:) name:kServiceEnteredBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterForegroundNotification:) name:kServiceEnteredForegroundNotification object:nil];
    
    [NSThread sleepForTimeInterval:0.5];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setLogView:nil];
    [super viewDidUnload];
}

- (IBAction)scanAction:(id)sender {
    NSLog(@"start scanning!");
    [[LeDiscovery sharedInstance] startScanningForUUIDString];
}

- (IBAction)stopScan:(id)sender {
    NSLog(@"stop scanning!");
    [[LeDiscovery sharedInstance] stopScanning];
}

- (IBAction)refreshTableView:(id)sender {
    
    if ([_logView isFirstResponder])
        [_logView resignFirstResponder];
    
    _logView.text = @"";
    [_tableView reloadData];
}

- (void)dealloc {
    [_tableView release];
    [_logView release];
    [super dealloc];
}


#pragma mark -
#pragma mark LeDiscoveryDelegate
/****************************************************************************/
/*                       LeDiscoveryDelegate Methods                        */
/****************************************************************************/
- (void) discoveryDidRefresh:(NSString*)message
{
    [_tableView reloadData];
    
    [self refreshLogView:message];
}

- (void) discoveryStatePoweredOff
{
    NSLog(@"discoveryStatePoweredOff");

    NSString *title     = @"Bluetooth Power";
    NSString *message   = @"You must turn on Bluetooth in Settings in order to use LE";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark LeServiceProtocol
- (void) serviceDidChangeStatus:(LeService*)service
{
    NSLog(@"serviceDidChangeStatus");
}

- (void) serviceDidReset
{
    NSLog(@"serviceDidReset");
}

- (void)didUpdateValueForCharacteristic:(NSString*)message
{
    NSLog(@"didUpdateValueForCharacteristic:%@", message);
    [self refreshLogView:message];
}

- (void)didEnterBackgroundNotification:(NSNotification*)notification
{
    NSLog(@"Entered background notification called.");
    for (LeService *service in [[LeDiscovery sharedInstance] connectedServices]) {
        [service enteredBackground];
    }
}

- (void)didEnterForegroundNotification:(NSNotification*)notification
{
    NSLog(@"Entered foreground notification called.");
    for (LeService *service in [[LeDiscovery sharedInstance] connectedServices]) {
        [service enteredForeground];
    }
}

- (void)refreshLogView:(NSString*)message
{
    _logView.text =[ NSString stringWithFormat:@"%@\r\n%@", _logView.text,message];
    [_logView scrollRangeToVisible:NSMakeRange([_logView.text length], 0)];
}

- (void)localNotification
{
    UILocalNotification *noti = [[UILocalNotification alloc] init];
        
    //设置推送时间]
    noti.fireDate = nil;
    //设置时区
    noti.timeZone = [NSTimeZone defaultTimeZone];
    //设置重复间隔
    noti.repeatInterval = kCFCalendarUnitDay;
    //推送声音
    noti.soundName = UILocalNotificationDefaultSoundName;
    //内容
    noti.alertBody = @"Alert";
    noti.hasAction = YES;
    noti.alertAction = @"BT4";
    
    //显示在icon上的红色圈中的数子
    noti.applicationIconBadgeNumber = 1;
    //添加推送到uiapplication
    UIApplication *app = [UIApplication sharedApplication];
    [app scheduleLocalNotification:noti];
    [noti release];
}

@end
