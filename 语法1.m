MyComputer *Computer1 = [[MyComputer alloc] init]; //定义一个对象

@interface MyComputer:NSObject
{
	NSString * computerName;
	NSString * computerType;    //变量
}
-(NSString *) computerName;
-(void) setComputerName;
-(NSString *) computerType;
-(void) setComputerType;	//方法
@end

@interface MyComputer:NSObject
{
	int speed;      //成员变量
}
-(void) print;		//方法
@end
@implementation
(void) print            //方法的实现
{
	
}
@end

MyComputer*computer = [[MyComputer alloc]init]; //创建一个MyComputer的实例
[computer setComputerName: @"Tony"]; //呼叫setComputerName方法
[computer release];                  //释放computer


#import <CoreLocation/CoreLocation.h> //引用CoreLocation框架中的CoreLocation.h头文件

@interface Car : NSObject   //类的名字为Car，继承于NSObject
{
	NSString * name;  //类的属性，名字
}
-(NSString *) name;                    //类的实例方法
-(void) setName: (NSString *)str;      //类的实例方法
+(float) mileFromKilomtre: (float)km;  //类的方法
@end

Car*myCar = [[Car alloc] init];   //实例化一个Car的对象
[myCar setName: @"My Benz"];      //呼叫类的实例方法setName
[myCar release];	          //释放实例

[Car mileFromKilometre: 105.6];   //呼叫类方法mileFromKilometre，不需要实例化

-(int) calculateTriangleAreaWithLength: (int)length Height: (int)height;  //计算三角形面积方法的例子说明
[myArray insertObject: anObject atIndex:0];

<!--字符串--!>

NSString*myString = @"My string";  //定义字符串常量
NSString*myString = [NSString stringWithFormat: @"%d %s %@", 1, "C String", @"Obj-C String"]
//%d %s和C语言风格一样分别替换整形和字符串，%@替换Objective-C的字符串

printf("log message"); //C语言的输出
NSLog(@"log message"); //Objective-C语言的输出

<!--数据类型--!>

#import <Foundation/Foundation.h>
int main (int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init]; //声明对象释放池
	int integerVar = 100;
	float floatingVar = 331.79;
	double doubleVar = 8.44e+11;
	char charVar = 'W';
	NSLog(@"integerVAr=%i", integerVar);
	NSLog(@"floatingVar=%f", floatingVar);
	NSLog(@"doubleVar=%e", doubleVar);
	NSLog(@"doubleVar=%g", doubleVar);
	NSLog(@"charVar=%c", charVar);
	[pool drain];           //释放对象池
	return 0;
}

//最终输出的结果
integerVar=100
floatingVar=331.790009
doubleVar=8.440000e+11 
doubleVar=8.44e+11
charVar='W'

Typedef struct objc_object{
	Class isa;
}*id;

id object; //声明一个id类型的对象
object = [[Car alloc] init]; //实例化一个Car的对象并且传递给object，这个时候object是Car的对象
[object run]; //呼叫Car类的run方法
object = [[Bike alloc] init]; //实例化一个Bike的对象并且传递给object，这个时候object是Bike的对象
[object run]; //呼叫Bike类的run方法

Typedef signed char BOOL

Car * myCar = nil;
if(myCar)
{
	[myCar startEngine];
}

<!--运算表达式--!>
#import <Foundation/Foundation.h>
int main(int argc,  char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int a = 100;
	int b = 2;
	int c = 25;
	int d = 4;
	int result;
	result = a - b;
	NSLog(@"a - b=%i", result);
	result = a * c;
	NSLog(@"a * c=%i", result);
	result = a / c;
	NSLog(@"a / c=%i", result);
	result = a + b * c;
	NSLog(@"a + b * c=%i", result);
	NSLog(@"a * b + c * d=%i", result);
	Result = a % b;
	NSlog(@"a % b=%i", Result);
	[pool drain];
	return 0;
}

<!--for循环--!>

#import <Foundation/Foundation.h>
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int n, triangularNumber;
	triangularNumber = 0;
	for(n=1; n<=200; n=n+1)
	{
		triangularNumber += n;
	}
	NSLog(@"The 200th triangular number is %i", triangularNumber);
	[pool drain];
	return 0;
}

<!--while循环--!>
#import <Foundation/Foundation.h>
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int count = 1;
	while(count <= 5)
	{
		NSLog(@"%i", count);
		++count;
	}
	[pool drain];
	return 0;
}

<!--do循环--!>
#import <Foundation/Foundation.h>
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int number, right_digit;
	NSLog(@"Enter your number.");
	scanf("%i", &number);   //接受键盘输入
	do
	{
		right_digit = number % 10;
		NSLog(@"%i", right_digit);
		number /= 10;
	}
	while(number != 0);
	[pool drain];
	return 0;
}

<!--if语句--!>
#import <Foundation/Foundation.h>
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int number;
	NSLog(@"Type in you number:");
        scanf("%i", &number);
	if (number < 0)
		number = -mumber;
	NSLog(@"The absolute value is %i", number);
	[pool drain];	
	return 0;	
}

<!--if else 语句--!>
#import <Foundation/Foundation.h>
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int number_to_test, remainder;
	NSLog (@"Enter your number to be tested:");
	scanf("%i", &number_to_test);
	remainder = number_to_test % 2;
	if (remainder == 0)
		NSLog (@"The number is even.");
	else
		NSLog (@"The number is ood.");
	[pool drain];
	return 0;
}

<!--switch 语句-->
#import <Foundation/Foundation.h>
int main(int argv, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int operation = 1;
	switch (operation)
	{
		case 1:
			NSLog(@" operation=1");
			break;
		case 2:
			NSLog(@" operaiton=2");
			break;
		case 3:
			NSLog(@" operation=3");
			break;
		case 4:
			NSLog(@" operation=4");
			break;
		default:
			NSLog(@"Unknown operator.");
			break;
	}
	[pool drain];
	return 0;
}

//三元表达式
s = (x < 0) ? -1 : x * x;































