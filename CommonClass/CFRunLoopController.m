

//
//  CFRunLoopController.m
//  CommonClass
//
//  Created by blazer on 2017/9/20.
//  Copyright © 2017年 blazer. All rights reserved.
//
//
//  解决加载大图片界面卡顿的问题

#import "CFRunLoopController.h"

//定义block
typedef void(^RunloopBlock)(void);


@interface CFRunLoopController ()

//用来添加任务
@property(nonatomic, strong) NSMutableArray *tasks;

//最大任务数
@property(nonatomic, assign) NSUInteger maxQueueLength;

@end

@implementation CFRunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
}


//监听RunLoop
-(void)addRunLoopObserver{
    //拿到当前的RunLoop
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
//    CFRunLoopGetMain();   拿到主RunLoop
    
    //上下文
    /*
     * 解释
     * 这个上下文的作用就是把self丢进去，因为
     * 在C语言是没有Block 只能是用函数指针
     * 就是用于回调的时候呆会拿到self
     *  
     * 在创建的观察者的时候  就会用到这个上下文
     */
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    //创建观察者
    static CFRunLoopObserverRef runloopObserver;
    
    runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callback, &context);
    
    
    //添加到当前的RunLoop中
    CFRunLoopAddObserver(runLoop, runloopObserver, kCFRunLoopCommonModes);
    
    CFRelease(runloopObserver);
}

//RunLoop执行一次就会进行回调  而且是循环执行的
void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    //拿到控制器
    
    CFRunLoopController *vc = (__bridge CFRunLoopController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    
    //每次执行一个Block, 执行完一个，删除一个
    RunloopBlock block = vc.tasks.firstObject;
    block();
    [vc.tasks removeObjectAtIndex:0];
     
    NSLog(@"来了");
    
}

- (void)addTask:(RunloopBlock)task{
    //将任务放到数组中
    [self.tasks addObject:task];
    
    if (self.tasks.count > self.maxQueueLength) {
        [self.tasks removeObjectAtIndex:0];
    }
    
}


@end
