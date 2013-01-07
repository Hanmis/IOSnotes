/*
1协议
协议，类似于java或者C#语言中的接口，它限制了实现类必须拥有哪些方法。
它是对对象行为的定义，也是对功能的规范
示例：
*/
//GoodChild.h
#import <Foundation/Foundation.h>
@protocol GoodChild <NSObject>
//好孩子要孝顺虔诚
- (void)filialPiety;
@end

//Student.h
#import <Foundation/Foundation.h>
#import "GoodChild.h"

@interface Student : NSObject<GoodChild>
@end

//Student.m
#import "Student.h"
@implementation Student
- (id)init
{
	self = [super init];

	if (self)
	{
		//Initialization code here
	}

	return self;
}
- (void)filialPiety 
{
	NSLog(@"孝顺父母。。");
}
@end
/*
此例中定义了一个协议GoodChild,类Student实现了此协议，所以必须有filialPiety方法。
每个类虽然有一个父类，但可以实现多个协议，以逗号隔开便可。语法如下:
*/
@interface Student : NSObject<协议1，协议2>
@end

/*
2委托
委托是objc中使用非常频繁的一种设计模式，它的实现与协议的使用是分不开的，让我们看一个综合的例子：
小公司的老板日常的工作是管理公司、教导新员工、发工资与接电话
其中管理公司、教导新员工是老板要亲为的。
而发工资与接电话老板希望招聘一个秘书来帮忙，于是对秘书的要求就是要略懂出纳工资，要能帮忙
领导接电话。而这两项要求便是协议，对类功能的限定。
*/

//SecProtocol.h
#import <Foundation/Foundation.h>
@protocol SecProtocol<NSObject>

//发工资
- (void)payoff;
//接电话
- (void)tel;
@end

//Sec.h
#import <Foundation/Foundation.h>
#import "SetProtocol.h"
@interface Sec : NSObject<SetProtocol>

@end

//Sec.m
#import "Sec.h"
@implementation Sec
- (id)init
{
	if ([super init])
	{
		//Initalization code here
	}
	return self;
}
- (void)payoff 
{
	NSLog(@"sec payoff");
}
- (void)tel
{
	NSLog(@"sec tel");
}
@end

//紧接着是老板的类

//Boss.h
#import <Foundation/Foundation.h>
#import "SecProtocol.h"

@interface Boss : NSObject
//此属性用于指定秘书对象，此对象必须实现SecProtocol协议
@property(nonatomic, retain) id<SecProtocol> delegate;
//管理
- (void)manage;
//教导新员工
- (void)teach;
@end

//Bosh.m
#import "Boss.h"
@implementation Boss
@synthesize delegate = _delegate;
- (id)init
{
	if ([super init])
	{
		//Initiaization code here
	}
	return self;
}
- (void)manage
{
	NSLog(@"boss manage");
}
- (void)teach 
{
	NSLog(@"boss teach");
}
- (void)payoff
{
	NSAutoReleasePool *p = [[NSAutoReleasePool alloc] init];
	[_delegate payoff];
	[p release];
}
- (void)tel 
{
	NSAutoReleasePool *p = [[NSAutoReleasePool alloc] init];
	[_delegate tel]
	[p release];
}
@end

/*
那么老板就具有这4个方法，当调用前2个时就是自己完成功能，而调用后2个是则转为调用秘书的方法。
此时我们跟秘书对象就叫做代理对象，代理模式的名字由来于此。，
最后调用测试：
*/
//mian.m
#improt <Foundation/Foundation.h>
#import "Boss.h"
#import "Sec.h"
int main (int argc, const char *argv[])
{
	NSAutoReleasePool *pool = [[NSAutoReleasePool alloc] init];
	//实例化老板对象
	Boss *boss = [[[Boss alloc] init] autorelease];
	//实例化秘书对象
	Sec *sec = [[[Sec alloc] init] autorelease];
	//设置老板的代理对象为秘书
	boss.delegate = sec;
	//调用这四个方法
	[boss payoff];

	[boss tel];

	[boss manage];

	[boss teach];

	[pool drain];
	return 0;
}