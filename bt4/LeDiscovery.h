#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "LeService.h"



/****************************************************************************/
/*			UI protocols					    */
/****************************************************************************/
@protocol LeDiscoveryDelegate <NSObject>
- (void) discoveryDidRefresh:(NSString*)message;
- (void) discoveryStatePoweredOff;
@end



/****************************************************************************/
/*			Discovery class					    */
/****************************************************************************/
@interface LeDiscovery : NSObject

+ (id) sharedInstance;


/****************************************************************************/
/*			UI controls					    */
/****************************************************************************/
@property (nonatomic, assign) id<LeDiscoveryDelegate> discoveryDelegate;
@property (nonatomic, assign) id<LeServiceProtocol> peripheralDelegate;


/****************************************************************************/
/*			Actions						    */
/****************************************************************************/
- (void) startScanningForUUIDString;
- (void) stopScanning;

- (void) connectPeripheral:(CBPeripheral*)peripheral;
- (void) disconnectPeripheral:(CBPeripheral*)peripheral;


/****************************************************************************/
/*			Access to the devices				    */
/****************************************************************************/
@property (retain, nonatomic) NSMutableArray *foundPeripherals;
@property (retain, nonatomic) NSMutableArray *connectedServices;	// Array of LeTemperatureAlarmService
@end
