/*
1Э��
Э�飬������java����C#�����еĽӿڣ���������ʵ�������ӵ����Щ������
���ǶԶ�����Ϊ�Ķ��壬Ҳ�ǶԹ��ܵĹ淶
ʾ����
*/
//GoodChild.h
#import <Foundation/Foundation.h>
@protocol GoodChild <NSObject>
//�ú���ҪТ˳��
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
	NSLog(@"Т˳��ĸ����");
}
@end
/*
�����ж�����һ��Э��GoodChild,��Studentʵ���˴�Э�飬���Ա�����filialPiety������
ÿ������Ȼ��һ�����࣬������ʵ�ֶ��Э�飬�Զ��Ÿ�����ɡ��﷨����:
*/
@interface Student : NSObject<Э��1��Э��2>
@end

/*
2ί��
ί����objc��ʹ�÷ǳ�Ƶ����һ�����ģʽ������ʵ����Э���ʹ���Ƿֲ����ģ������ǿ�һ���ۺϵ����ӣ�
С��˾���ϰ��ճ��Ĺ����ǹ���˾���̵���Ա������������ӵ绰
���й���˾���̵���Ա�����ϰ�Ҫ��Ϊ�ġ�
����������ӵ绰�ϰ�ϣ����Ƹһ����������æ�����Ƕ������Ҫ�����Ҫ�Զ����ɹ��ʣ�Ҫ�ܰ�æ
�쵼�ӵ绰����������Ҫ�����Э�飬���๦�ܵ��޶���
*/

//SecProtocol.h
#import <Foundation/Foundation.h>
@protocol SecProtocol<NSObject>

//������
- (void)payoff;
//�ӵ绰
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

//���������ϰ����

//Boss.h
#import <Foundation/Foundation.h>
#import "SecProtocol.h"

@interface Boss : NSObject
//����������ָ��������󣬴˶������ʵ��SecProtocolЭ��
@property(nonatomic, retain) id<SecProtocol> delegate;
//����
- (void)manage;
//�̵���Ա��
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
��ô�ϰ�;�����4��������������ǰ2��ʱ�����Լ���ɹ��ܣ������ú�2������תΪ��������ķ�����
��ʱ���Ǹ��������ͽ���������󣬴���ģʽ�����������ڴˡ���
�����ò��ԣ�
*/
//mian.m
#improt <Foundation/Foundation.h>
#import "Boss.h"
#import "Sec.h"
int main (int argc, const char *argv[])
{
	NSAutoReleasePool *pool = [[NSAutoReleasePool alloc] init];
	//ʵ�����ϰ����
	Boss *boss = [[[Boss alloc] init] autorelease];
	//ʵ�����������
	Sec *sec = [[[Sec alloc] init] autorelease];
	//�����ϰ�Ĵ������Ϊ����
	boss.delegate = sec;
	//�������ĸ�����
	[boss payoff];

	[boss tel];

	[boss manage];

	[boss teach];

	[pool drain];
	return 0;
}