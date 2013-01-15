#import "LeService.h"
#import "LeDiscovery.h"


//NSString *kPeripheralUUIDString = @"00000000-0000-0000-F444-9624C1C18971";
//NSString *kServiceUUIDString = @"FFF0";

NSString *kPeripheralUUIDString = @"00000000-0000-0000-E396-A747371FD010";
NSString *kServiceUUIDString = @"FFE0";
//NSString *kCharacteristicUUIDString = @"FFF1";

NSString *kServiceEnteredBackgroundNotification = @"kServiceEnteredBackgroundNotification";
NSString *kServiceEnteredForegroundNotification = @"kServiceEnteredForegroundNotification";

@interface LeService() <CBPeripheralDelegate> {
@private
    CBPeripheral *servicePeripheral;
    CBService *btService;
    CBUUID *characteristicUUID;
    id<LeServiceProtocol> peripheralDelegate;
}
@end



@implementation LeService


@synthesize peripheral = servicePeripheral;
@synthesize delegate;


#pragma mark -
#pragma mark Init
/****************************************************************************/
/*								Init										*/
/****************************************************************************/
- (id) initWithPeripheral:(CBPeripheral *)peripheral controller:(id<LeServiceProtocol>)controller
{
    self = [super init];
    if (self) {
        servicePeripheral = [peripheral retain];
        [servicePeripheral setDelegate:self];
	peripheralDelegate = controller;
        
//        characteristicUUID	= [[CBUUID UUIDWithString:kCharacteristicUUIDString] retain];
	}
    return self;
}


- (void) dealloc {
	if (servicePeripheral) {
		[servicePeripheral setDelegate:[LeDiscovery sharedInstance]];
		[servicePeripheral release];
		servicePeripheral = nil;
        
        	[characteristicUUID release];
    	}
    	[super dealloc];
}


- (void) reset
{
	if (servicePeripheral) {
		[servicePeripheral release];
		servicePeripheral = nil;
	}
}



#pragma mark -
#pragma mark Service interaction
/****************************************************************************/
/*				Service Interactions			    */
/****************************************************************************/
- (void) start
{
	CBUUID	*serviceUUID = [CBUUID UUIDWithString:kServiceUUIDString];
	NSArray	*serviceArray = [NSArray arrayWithObjects:serviceUUID, nil];

    	[servicePeripheral discoverServices:serviceArray];
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
	NSArray *services = nil;
	NSArray	*uuids = [NSArray arrayWithObjects:characteristicUUID, nil]; // Characteristic

	if (peripheral != servicePeripheral) {
		NSLog(@"Wrong Peripheral.\n");
		return ;
	}
    
        if (error != nil) {
        	NSLog(@"Error %@\n", error);
		return ;
	}

	services = [peripheral services];
	if (!services || ![services count]) {
		return ;
	}

	btService = nil;
    
	for (CBService *aService in services) {
//        NSLog(@"service.UUID:%@", aService.UUID);
        printf("@service.UUID:%s\n", [self CBUUIDToString:aService.UUID]);
		if ([[aService UUID] isEqual:[CBUUID UUIDWithString:kServiceUUIDString]]) {
			btService = aService;
			break;
		}
	}

	if (btService) {
		[peripheral discoverCharacteristics:uuids forService:btService];
	}
}


-(const char *) CBUUIDToString:(CBUUID *) UUID {
	return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
{
	NSArray *characteristics = [service characteristics];
	CBCharacteristic *characteristic;
    
	if (peripheral != servicePeripheral) {
		NSLog(@"Wrong Peripheral.\n");
		return ;
	}
	
	if (btService != service) {
		NSLog(@"Wrong Service.\n");
		return ;
	}
    
    	if (error != nil) {
		NSLog(@"Error %@\n", error);
		return ;
	}
    
	for (characteristic in characteristics) {
		[peripheral setNotifyValue:YES forCharacteristic:characteristic];
		[peripheral readValueForCharacteristic:characteristic];
	}
}

#pragma mark - WriteData

- (void)sendData {
	[servicePeripheral writeValue:nil forCharacteristic:nil type:CBCharacteristicWriteWithResponse];
}

#pragma mark -
#pragma mark Characteristics interaction
- (void)enteredBackground
{
	NSLog(@"enter background");
	[self setAllNotifyValue];
}

- (void)enteredForeground
{
	NSLog(@"enter foreground");
}

- (void)setAllNotifyValue
{
    for (CBService *service in [servicePeripheral services]) {
        if ([[service UUID] isEqual:[CBUUID UUIDWithString:kServiceUUIDString]]) {
            
            // Find the temperature characteristic
            for (CBCharacteristic *characteristic in [service characteristics]) {
                [servicePeripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
	if (peripheral != servicePeripheral) {
		NSLog(@"Wrong peripheral\n");
		return ;
	}

        if ([error code] != 0) {
		NSLog(@"Error %@\n", error);
		return ;
	}
    
    	NSString *message = [[NSString stringWithFormat:@"didUpdateValueForCharacteristic, UUID:%@", characteristic.UUID] retain];
    	[delegate didUpdateValueForCharacteristic:message];

}

- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    /* When a write occurs, need to set off a re-read of the local CBCharacteristic to update its value */
    [peripheral readValueForCharacteristic:characteristic];
}
@end
