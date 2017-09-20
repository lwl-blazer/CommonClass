//
//  ViewController.m
//  CommonClass
//
//  Created by blazer on 2017/8/25.
//  Copyright © 2017年 blazer. All rights reserved.
//

/*
 通知是什么
 使用(同步、异步)
   默认情况下是同步处理
 
   如果需要异步的话，需要用到通知队列
 
 通知队列(线程关系、合并等，系统哪些消息做了合并)
 底层通信 port (同线程处理、不同线程处理)
 分析层次结构(通知中心)
 思维贯穿:window(自己初始化队列)  drawReact(合并)  队列 FIFO(dispatch queue） defaultCenter CurrentRoop
 */

#import "ViewController.h"
#import "EOCView.h"
#import "Person.h"
#import "NSObject+Sum.h"
#import "NSObject+KVO.h"

@interface ViewController ()<NSPortDelegate>{
    EOCView *_eocView;
    NSPort *_port;
}

@property(nonatomic, strong) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _eocView = [[EOCView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_eocView];
    
    
// 通知中心维护了一个列表，里面有很多系统通知
// object是表示指定接受某个对象的通知  nil是接收所有的
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"EOCClass" object:nil];
    
//    要实现真正意义上的异步发送的话， 就是指一个线程里发送，在其它线程里接收的一个异步过程，需要用到NSPort(端口)
    _port = [[NSPort alloc] init];
    _port.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:_port forMode:NSRunLoopCommonModes];

    
    
//    将block当做方法的返回值, 完成简单的链式语法
    Person *p = [[Person alloc] init];
    p.run(20).eat.run(10).eat.eat.run(12);
    

//链式编程
    int a = [self bl_makeSum:^(SumManager *manager) {
        manager.add(10).add(20);
    }];
    NSLog(@"%d", a);
    
    //isa指针  指向真实类型
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [p bl_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    _p = p;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@", _p.name);
    NSLog(@"%@", keyPath);
}


//发送
- (void)sendPort{
    NSLog(@"发送线程1： thread:%@", [NSThread currentThread]);
    [_port sendBeforeDate:[NSDate date] msgid:1212 components:nil from:nil reserved:0];
    NSLog(@"发送结束3");
}

//处理
- (void)handlePortMessage:(NSPortMessage *)message{
    NSLog(@"处理任务线程2：%@", [NSThread currentThread]);
    NSObject *messageObj = (NSObject *)message;
   NSLog(@"%@", [messageObj valueForKey:@"msgid"]);
}

//异步  通知队列   NSPostNow就是同步

- (void)notificationQueue{
//    object 是发送者
    NSNotification *notifi = [NSNotification notificationWithName:@"EOCClass" object:nil];
    
    //获取默认的通知队列
    NSNotificationQueue *notificationQueue = [NSNotificationQueue defaultQueue];
    NSLog(@"send before: 1: %@", [NSThread currentThread]);
    
//    postignStyle 发送的时机    cocalesceMask:消息合并   按名字合并按发送者合并
    [notificationQueue enqueueNotification:notifi postingStyle:NSPostWhenIdle coalesceMask:NSNotificationNoCoalescing forModes:nil];
    NSLog(@"send over 3");
    
/*
 通知队列跟线程的关系
 每一个线程都有一个通知队列
 每一个线程都有一个RunLoop
 */
    
    //这样一个线程就不会结束掉
    NSPort * port = [[NSPort alloc] init];
    [[NSRunLoop currentRunLoop] addPort:port forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}


//发送通知  同步
- (void)sendNotifion{
    NSLog(@"send before: 1: %@", [NSThread currentThread]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EOCClass" object:nil];
    NSLog(@"send over 3");
}

//处理通知
- (void)handleNotification:(NSNotification *)notify{
    NSLog(@"ing ~ notification 2 : %@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//同步    [self sendNotifion];
//异步    [self notificationQueue];
    
/*调用系统方法，系统也是按照通知队列，发送时机是空闭时  消息合并是按名字进行合并， 最终只会调用一次  */
//    [_eocView setNeedsDisplay];  //手动调用drawReact
//     [_eocView setNeedsDisplay];
//     [_eocView setNeedsDisplay];
    
//    开一个线程  如果用通知队列 是没有被处理 同步是没有问题   所以线程跟通知队列是有关系的
    [NSThread detachNewThreadSelector:@selector(sendPort) toTarget:self withObject:nil];
    
    
    
//   执行block

    
    //KVO
    static int i = 0;
    i ++;
    _p.name = [NSString stringWithFormat:@"%d", i];
}


@end
