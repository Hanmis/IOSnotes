#import <Foundation/NSObject.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSValue.h>

int main(int argc, char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	//实例化一个NSNumber对象myInt，因为呼叫了一次alloc方法，其引用计数加1，为+1
	NSNumber *myInt = [[NSNumber alloc] initWithInt: 100];
	//输出myInt的引用计数
	NSLog (@"myInt retain count=%1x", (unsigned long) [myInt retainCount]);
	//myInt对象呼叫一次retain方法，引用计数再加1，为+2
	[myInt retain];
	//输出myInt的引用计数
	NSLog (@"myInt retain count after retain=%1x", (unsigned long) [myInt retainCount]);
	//myInt对象呼叫一次release方法，引用计数减1，为+1，此时myInt对象仍存在，并未释放掉
	[myInt release];
	//输出myInt的引用计数
	NSLog (@"myInt retain count after release=%1x", (unsigned long) [myInt retainCount]);
	//myInt对象呼叫copy方法，返回引用计数为1的实例，此时secInt的引用计数为+1，myInt的引用计数不变
	NSNumber * secInt = [myInt copy];
	//输出secInt的引用计数
	NSLog (@"secInt retain count after copy=%1x", (unsigned long) [secInt retainCount]);
	//secInt对象呼叫一次release方法，secInt的引用计数减1，此时为0，secInt被彻底释放掉了
	[secInt release];
	//myInt对象呼叫一次release方法，secInt的引用计数减1，此时为0，secInt被彻底释放掉了
	[myInt release];
	
	[pool drain];
	return 0;
}

<!--对象释放池--!>
NSAutorelease *pool = [[NSAutoreleasePool alloc] init];
//声明对象以及对对象进行操作
[pool drain]

<!--对象自动释放事例--!>
#import <Foundation/NSObject.h>
#import <Foundation/NSAutoreleasePool.h>
@interface Foo: NSObject
{
	int x;
}
@end
@implementation Foo
@end
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	Foo *myFoo = [[Foo alloc] init];
	NSLog (@"myFoo retain count=%x", [myFoo retainCount]);
	[pool drain];
	NSLog (@"after pool drain=%x", [myFoo rtaincount]);

	pool = [[NSAutorelease alloc] init];
	
}

<!--继承--!>
//父类
@interface rootClass
-(void) rootClassMethod1;
-(void) rootClassMethod2;
-(void) rootclassMethod3;
@end

@implementation rootClass
-(void) rootClassMethod1
{
	NSLog (@"this is rootClassMethod1");
}
-(void) rootClassMethod2
{
	NSLog (@"this is rootClassMethod2");
}
-(void) rootClassMehtod3
{
	NSLog (@"this is rootClassMehtod3");
}
@end

//子类
@interface subClass : rootClass
-(void) rootClassMethod1;
-(void) subClassMethod;
@end

@implementation subClass
-(void) rootClassMethod1
{
	NSLog (@"this is rootClassMethod1 overwrite in subclass");
}
-(void) subClassMethod
{
	NSLog (@"this is subClassMethod");
}
@end

//main方法
int main(int argc, char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	rootClass * root = [[rootClass alloc] init];
	subClass * sub = [[subClass alloc] init];
	
	[root rootClassMethod1];
	[root rootClassMethod2];
	[root rootClassMethod3];

	[sub rootClassMethod1];
	[sub rootClassMethod2];
	[sub rootClassMethod3];
	[sub subClassMethod];	
}

//输出的结果
this is rootClassMethod1
this is rootClassMethod2
this is rootClassMethod3

this is rootClassMethod1 overwrite in subclass
this is rootClassMethod2
this is rootClassMethod3
this is subClassMethod

<!--多态--!>
#import <Foundation/Foundation.h>
//定义类A
@interface A : NSObject
-(void) print 
@end
@implementation A
-(void) print
{
	NSLog (@"this is class A");
}
@end
//定义类B
@interface B : NSObject
-(void) print
@end
@implementation B
-(void) print
{
	NSLog (@"this is class B");
}
@end

int main(int argc, char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	A *a = [[A alloc] init];
	B *b = [[B alloc] init];
	[a print];
	[b print];
	[a release];
	[b release];
	[pool drain];
	return 0;
}

<!--动态绑定--!>

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	id temObj;
	A *a = [[A alloc] init];
	B *b = [[B alloc] init];
	temObj = a;
	[temObj print];
	temObj = b;
	[temObj print];
	[a release];
	[b release];
	[pool drain];
	return 0;
}

<!--协议--!>
//定义协议protocolA
@protocol protocolA
-(void) protocolMethod1;
-(void) protocolMethod2;
-(void) protocolMethod3;
@end

@interface myClass : NSObject<protocolA>
{
}
@end
@implementation myClass
-(void) protocolMethod1()
{
	NSLog(@"implement protocolMethod1");
}
-(void) protocolMethod2()
{
	NSLog(@"implement protocolMethod2");
}
-(void) protocolMethod3()
{
	NSLog(@"implement protocolMethod3");
}
@end

<!--原始属性的定义--!>
@interface Student : NSObject
{
	NSString *Name;
	NSString *Address;
	Int ID;
}
+(id)student;
-(NSString*)Name;
-(NSString*)setName;(NSString *)aValue;
-(NSString*)Address;
-(NSString*)setAddresss;(NSString *)aValue;
-(NSString*)ID;
-(int*)setID;(int *)aValue;
-(NSString*)summary;
@end

<!--Objective-C 2.0属性功能--!>
//采用Objective-c 2.0的语法定义
@interface Student : NSObject
{
	NSString *Name;
	NSString *Address;
	Int ID;
}
+(id)student;
@property(copy, nonatomic) NSString *Name;
@property(retain, nonatomic) NSString *Address;
@property(assign, nonatomic) NSInteger *ID;
@property(readonly) NSString * summary;
@end
//第一种写法的接口的实现代码
@implementation Student
+(id) student
{
	Return [[[Student alloc] init] autorelease];
}
-(NSString *)Name
{
	Return Name;
}
-(void *)setName; (NSString *)aValue
{
	[Name autorelease];
	Name = [aValue copy];
}
-(NSString *)Address
{
	Return address;
}
-(void)setAddress; (NSString *)aValue
{
	[Address autorelease];
	address = [aValue retain];
}
-(NSInteger *) ID
{
	Return ID;
}
-(NSString*)setID; (NSString *)aValue
{
	Address = aValue;
}
-(NSString*)summary
{
	NSNumber *Idb = [NSNumber numbereWithInt:[self ID]];
	Return [NSString stringWithFormat:@"Name:%@--Address:%@--ID:%@",[self Name],[self Address],Idb];
}
@end

//实现部分换成Objective-C 2.0的写法
@implementation Student
@synthesize Name;
@synthesize Address;
@synthesize ID;

+(id) student
{
	Return [[Student alloc] init];
}
-(NSString *)summary
{
	NSNumber *Idb = [NSNumber numbereWithInt:[self ID]];
	Return [NSString stringWithFormat:@"Name:%@--Address:%@--ID:%@",[self Name],[self Address],Idb];
}

//@synthesize指令生成了相应的方法
//由于objective-C 2.0采用了垃圾回收，因此，student不需要autorelease，同时[self Name]和[self Address]被self.Name和self.Address替换了
int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	Student *newStudent = [Student student];
	newStudent.name = @"Peter.Steven";
	newStudent.Address = @"china";
	newStudent.ID = 012;
	NSLog (@"sudent summary is %@", newStudent.summry);
	[pool drain];
	Return 0;
} 
