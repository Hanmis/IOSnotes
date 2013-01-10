/*线程*/

[NSThread detachNewThreadSelector:@selector(Address:) toTarget:aTarget withObject:object];

//detachNewThreadSelector是类NSThread类方法，它的功能就是分配一个子线程，它有三个参数
//参数1是子线程地址，参数2指明了线程地址所在的对象，参数3是要传个线程地址的参数

-(void) newThread
{
	//创建一个新的线程执行threadFunc
	[NSThread detachNewThreadSelector:@selector(threadFunc:) toTarget:self waitObejct:@"hellow"];
}
-(void) threadFunc:(NSString *)str
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSlog(str);
	//在主线程执行notifyFunc方法
	[self performSelectorOnMainThread: @selector(notifyFunc) withObject:self waitUnitDone:YES];
	[pool release];
}
-(void) notifyFunc
{
	NSLog (@"this is sub thread message");
}


