
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


/****************************************************************************/
/*			Service Characteristics				    */
/****************************************************************************/
extern NSString *kPeripheralUUIDString;                 //  Peripheral UUID
extern NSString *kServiceUUIDString;                    //  Service UUID
extern NSString *kCharacteristicUUIDString;             //  Characteristic

extern NSString *kServiceEnteredBackgroundNotification;
extern NSString *kServiceEnteredForegroundNotification;

/****************************************************************************/
/*			Protocol					    */
/****************************************************************************/
@class LeService;

typedef enum {
    kAlarmHigh  = 0,
    kAlarmLow   = 1,
} AlarmType;

@protocol LeServiceProtocol<NSObject>
- (void) serviceDidChangeStatus:(LeService*)service;
- (void) serviceDidReset;
- (void) didUpdateValueForCharacteristic:(NSString*)message;
@end


/****************************************************************************/
/*			BT service.                                         */
/****************************************************************************/
@interface LeService : NSObject

- (id) initWithPeripheral:(CBPeripheral *)peripheral controller:(id<LeServiceProtocol>)controller;
- (void) reset;
- (void) start;


/* Behave properly when heading into and out of the background */
- (void)enteredBackground;
- (void)enteredForeground;

@property (nonatomic, assign) id<LeServiceProtocol>  delegate;
@property (readonly) CBPeripheral *peripheral;
@end
