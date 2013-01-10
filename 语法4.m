#import <Foundation/foundation.h>
//定义一个C++类
class Hello
{
	private:
	id greetint_text;
	public:
	Hello()
	{
		greetint_text = @"Hello, world!";
	}
	Hello(const char* initial_greeting_text)
	{
		greeting_text = [[NSString alloc] initWithURF8String:initial_greeting_text];
	}
	void say_hello()
	{
		printf("%s\n", [greeting_text UTF8String]);
	}
}

//定义一个objective-c类 Greeting
@interface Greeting : NSObject
{
	Hello *hello;
}
//类的方法定义
-(void)init,
-(void)dealloc,
-(void)sayGreeting;
-(void)sayGreeting: (Hello*)greeting;
@end
@implementation Greeting
(id) init
{
	self = [super init];
	if (self)
	{
		//实例化一个C++对象，注意c++与Objective-c混用的时候最好使用new操作符来实例化C++对象
		hello = new Hello();
	}
	return self;
}
(void)dealloc
{
	delete hello;                  //删除c++对象hello
	[super dealloc];
}
(void)sayGreeting
{
	hello->say_hello;              //呼叫c++类Hello的say_hello函数
}
(void)sayGreeting: (Hello*)greeting
{
	greeting->say_hello();
}
@end

int main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	Greeting *greeting = [[Greeting alloc] init];  //实例化Greeting对象
	[greeting sayGreeting];                        //输出Hello，world！
	Hello *hello = new Hello("Bonjour, monde!");   //实例化Hello对象
	[greeting sayGreeting:hello];                        //输出 Bonjour，monde！
	delete hello;                                  //释放hello对象
	[greeting release];                            //释放greeting对象
	[pool drain];
	return 0;
}
