/*1、随机数的使用*/
//头文件的引用
#import<time.h>
#import<mach/mach_time.h>
//srandom()的使用
srandom((unsigned)(mach_absolute_time()&0xFFFFFFFF));
//直接使用random()来调用随机数

/*2、在UIImageView中旋转图像*/
float rotateAngle = M_PI;
CGAffineTransform transform = CGAffineTransfromMakeRotation(rotateAngle);
imageView.transform = transform;
//以上代码旋转imageView，角度为rotateAngle,方向可以自己测试！

/*3、在Quartz中如何设置旋转点*/
UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
imageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
//这个是把旋转点设置为底部中间，记住是在QuartzCore.framework中才得到支持。

/*4、创建.plist文件并存储*/
NSString *errorDesc; //用来存放错误信息
NSMutableDictionary *rootObj = [NSMutableDictionary dictionaryWithCapacity:4]; //NSDictionary,NSData等文件可以直接转化为plist文件
NSDictionary *innerDict;
NSString *name;
Player *player;
NSInteger saveIndex;

for (int i=0; i < [playerArray count]; i++)
{
	player = nil;
	player = [playerArray objectAtIndex:i];
	if (player == nil)
		break;
	name = player.playerName; //This "Player1" denotes the player name could also be the computer name
	innerDict = [self getAllNodeInfoToDictionary:player];
	[rootObj setObject:innerDict forKey:name]; //This"Player1"denotes the person who start this game
}
player = nil;
NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:(id)rootObj format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];

/*得到移动设备上的文件存放位置*/
NSString *documentsPath = [self getDocumentsDirectory];
NSString *savePath = [documentsPath stringByAppendingPathComponent:@"save.plist"];

/*存文件*/
if (plistData) {
	[plistData writeToFile:savePath atomically:YES];
} else {
	NSLog(errorDesc);
	[errorDesc release];
}
-(NSString *)getDocumentsDirectory {
	NSArray *paths = NSSearchPathForDiretoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

/*4.读取plist文件并转化为NSDictionary*/
NSString *documentsPath = [self getDocumentsDirectory];
NSString *fullPath = [documentsPath stringByAppendingPathComponent:@"save.plist"];
NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];

/*5.读取一般性文档文件*/
NSString *tmp;
NSArray *lines; //将文件转化为一行一行的
lines = [[NSString stringWithContentsOfFile:@"testFileReadLines.txt"] componentsSeparatedByString:@"\n"];
NSEnumerator *nse = [lines objectEnumerator];

//读取<>里的内容
while (tmp = [nse nextObject]) { 
	NSString *stringBetweenBrackets = nil;
        NSScanner *scanner = [NSScanner scannerWithString:tmp];
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&stringBetweenBrackets];
        NSLog([stringBetweenBrackets description]);
}
//对于读写文件，还有补充，暂时到此。随机数和文件读写在游戏开发中经常用到。所以把部分内容放在这，以便和大家分享，也当记录，便于查找。

/*6、隐藏NavigationBar*/
[self.navigationController setNavigationBarHidden:YES animated:YES];
//在想隐藏的ViewController中使用就可以了。


