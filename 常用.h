/*1、判断邮箱格式是否正确代码*/
//利用正则表达式
- (BOOL)isValidateEmail: (NSString *)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormate:@"SELF MATCHES%@",emailRegex];
	return [emailTest evaluateWithObject:email];
}

/*2、图片压缩*/
//用法：UIImage *yourImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
	//Create a graphics image context
	UIGraphicsBeginImageContext(newSize);
	//Tell the old image to draw in this newcontext,with the desired
	//new size
	[image drawInRect:CGRectMake(0, 0, newSize, width, newSize.height)];
}
