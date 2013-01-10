/**对象共享模式**/
static MyGizmoClass *sharedGizmoManager = nil;   //声明一个静态类实例变量这样保证该变量只存在一个
+(MygizmoClass*) sharedManager   //类方法，创建单态对象的方法
{
	@synchronized(self)        //关键字提供多线程互斥功能
 	{
		if (sharedGizmoManager == nil)
		{
			[[self alloc] init];
		}
	}
	return sharedGizmoManager;
}

+(id)allocWithZone:(NSZone *)zone    //重载实现类的实例化方法
{
	@synchronized(self)
}
