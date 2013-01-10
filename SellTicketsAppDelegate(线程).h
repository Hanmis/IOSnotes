// SellTickets.h
#import <Foundation/Foundation.h>
//定义售票接口
@interface SellTikects : NSObject {
	int tickets; //未售出的票数
	int count;   //售出的票数
	NSThread* ticketsThread1; //线程1
	NSThread* ticketsThread2; //线程2
	NSThread* ticketsThread3; //线程3
	NSCondition* ticketsCondition;//同步锁
}
-(void) ticket; //售票方法
@end

@implementation SellTikects 
//这个方法初始化了成员变量，并启动了三个线程，其中前两个线程执行售票方法run，第三个线程
//执行用于测试线程之间是否异步执行的asyn方法
-(void) ticket {
	tickets = 100;
	count = 0;
	ticketsCondition = [[NSCondition alloc] init];
	ticketsThread1 = [[NSTread alloc] initWithTarget:self selector:@selector(run) object:nil];
	[ticketsThread1 setName:@"Thread-1"];
	[ticketsThread1 start];
	ticketsThread2 = [[NSTread alloc] initWithTarget:self selector:@selector(run) object:nil];
	[tikectsThread2 setName:@"Thread-2"];
	[tikectsThread2 start];
	ticketsThread3 = [[NStread alloc] initWithTarget:self selector:@selector(run) object:nil];
	[tikectsThread3 setName=@"Thread-3"];
	[tikectsThread3 start];
	[NSThread sleepForTimeInterval:80];
}
//测试线程之间是否异步执行
-(void) asyn {
	[NSThread sleepForTimeInterval:5];
	printf("*****************************n");
}
-(void) run {
	while (YES) {
		//上锁
		[ticketsCondition lock];
		if(tickets > 0) {
			[NSThread sleepForTimeInterval:0.5];
			count = 100 - tickets;
			NSLog(@"当前票数是:%d,售出:%d,线程名:%@", tickets, count, [[NSThread currentThread] name]);
			tickets--;
		} else {
			break;
		}
		//解锁
		[ticketsCondition unlock];		
	}
}
-(void) dealloc {
	//回收线程、同步锁的实例
	[ticketsThread1	release];
	[ticketsThread2 release];
	[ticketsThread2 release];
	[ticketsCondition release];
	[super dealloc];

}
@end
int main(int argc, const char *argv[]) {
	SellTickets *st = [[SellTickets alloc] init];
	[st ticket];
	[st release];
	return 0;
}
