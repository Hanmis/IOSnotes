<!--枚举--!>
NSArray *array = [NSArray arrayWithObjects:
	@"One", @"Two", @"Three", @"Four", nil]; //创建array对象并且初始化赋值
for (NSString *element in array)
{
	NSLog (@"element: %@", element);  //遍历输出array中的每一个对象
}

NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
@"quattuor", @"four", @"quinque", @"five", @"sex", @"six", nil]; //创建dictionary对象并且初始化赋值
NSString *key;
for (key in dictionary)
{
	NSLog (@"English: %@, Lation: @%", key, [dictionary objectForKey:key]); //遍历输出dictionary中的每一个对象
}

NSArray *array = [NSArray arrayWithObjects:
@"One", @"Two", @"Three", @"four", nil];        //创建array对象并且初始化赋值
NSEnumerator *enumerator = [array reverseObjectEnumerator]; //得到一个array的枚举对象
for (NSString *element = [ebynerator nextObject])   //遍历每一个array中的对象
{
	if([element isEqualToString:@"Three"]){
		break;
	}
}

NSArray *array = /* 假设这个对象存在*/；
int i;
for (i=0; i< [array count]; ++i)
{
	NSLog (@"Element at index %u is: %@", i, [array objectAtIndex: i]);
}

NSArray *array = /*假设对象存在*/；
for (id element in array)
{
	if(/*对对象做条件判断*/)
	{
		//执行
	}
}


NSArray *array = /*假设对象存在*/；
NSUinteger index = 0;
for(id element in array)
{
	if (index != 0)
	{	
		NSLog (@"Element at index %u is: %@", index, element); //输出对象
	}
	if (++index >= 6) //如果index超过6，就跳出枚举的循环
	{
		break
	}
}
