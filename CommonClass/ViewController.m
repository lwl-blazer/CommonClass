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

#import <Masonry/Masonry.h>
#import "BLRangeSlider.h"
#import "HotelDetailFilterItemView.h"

#import "SMVerticalSegmentedControl.h"
#import "BLVerticalSegmentControl.h"
#import "ViewController2.h"

#import "LinkedList.h"

@interface ViewController ()<NSPortDelegate>{
    EOCView *_eocView;
    NSPort *_port;
}

@property(nonatomic, strong) Person *p;

@property(nonatomic, strong) UIView *subView;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;

@property(nonatomic, strong) HotelDetailFilterItemView *itemView;
@property(nonatomic, strong) BLVerticalSegmentControl *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LinkedList *list = [[LinkedList alloc] init];

//    SMVerticalSegmentedControl *segment = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:@[@"时间", @"航空公司", @"出发机场", @"到达机场", @"舱位"]];
//    segment.frame = CGRectMake(20,100, 200, 300);
//
//    segment.textAlignment = SMVerticalSegmentedControlTextAlignmentCenter;
//    segment.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
//    segment.selectionIndicatorThickness = 0;
//    segment.selectionBoxBorderWidth = 1;
//    segment.selectedTextColor = [UIColor colorWithRed:43/255.0 green:156/255.0 blue: 236/255.0 alpha:1.0];
//    segment.selectionIndicatorColor = [UIColor whiteColor];
//    segment.selectionBoxBackgroundColorAlpha = 1.0f;
//    segment.segmentEdgeInset=UIEdgeInsetsZero;
//    [self.view addSubview:segment];
    
    
    self.segment = [[BLVerticalSegmentControl alloc] initWithFrame:CGRectMake(20,100, 200, 300)
                                                                          sectionTitles:@[@"时间", @"航空公司", @"出发机场", @"到达机场", @"舱位"]];
    self.segment.backgroundColor = [UIColor yellowColor];
    [self.segment.selectContentIndex addObject:@(3)];
    [self.view addSubview:self.segment];
    
    /*
    self.itemView = [[HotelDetailFilterItemView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 40) buttons:@[@"企业付",

    [self.view addSubview:self.itemView];
    */
    /*
    BLRangeSlider *slider = [[BLRangeSlider alloc] initWithFrame:CGRectMake(20, 100, 500, 30)];
    slider.minValue = 0;
    slider.maxValue = 1000;
    [self.view addSubview:slider];
    */
    //[self createLabel];
    
    
   // [[BLPingService sharedManager] startPingHost:@"www.baidu.com" packetCount:10 resultHandler:nil];
    
//    [[PhoneNetManager shareInstance] netStartPing:@"www.baidu.com" packetCount:10 pingResultHandler:^(NSString * _Nullable pingres) {
//        NSLog(@"----%@", pingres);
//    }];
    
    
    /*_eocView = [[EOCView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
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
    
    _p = p;*/
}



- (IBAction)insertAction:(id)sender {
    
 
    
    
//    [self.segment.selectContentIndex addObject:@(0)];
//    [self.segment setNeedsDisplay];
    /*
   NSArray *arr = @[@"不限",
     @"150以下",
     @"150-300",
     @"300-600",
     @"600-800",
     @"800-1000",
     @"1000以上"];
    NSInteger i = arc4random() % 7;
    NSLog(@"%@", arr[i]);
    
    [self.itemView insertSelectFilterItemWithIndex:0 itemName:arr[i]];*/
}


- (void)createLabel{
    self.subView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.subView];
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.leading.trailing.mas_offset(0);
        make.height.mas_offset(100);
    }];
    
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label1.text = @"出发地";
    self.label1.textColor = [UIColor whiteColor];
    [self.subView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label2.text = @"目的地";
    self.label2.textColor = [UIColor whiteColor];
   
    self.label2.textAlignment = NSTextAlignmentRight;
    [self.subView addSubview:self.label2];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_offset(20);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(self.subView.mas_centerY);
        make.width.mas_offset(200);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_offset(-20);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(self.subView.mas_centerY);
        make.width.mas_offset(200);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [self.subView addSubview:btn];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.subView.mas_centerX);
        make.bottom.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (void)buttonAction{
    
    CGFloat margin = self.label2.frame.origin.x - self.label1.frame.origin.x;
    NSLog(@"%lf", margin);
    
    self.label1.transform = CGAffineTransformTranslate(self.label1.transform, margin, 0);
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


- (void)gcdDemo5{
    dispatch_queue_t q = dispatch_queue_create("AllQueue", DISPATCH_QUEUE_CONCURRENT);
    
    void (^task) () = ^{
        dispatch_sync(q, ^{
            
        });
        
        dispatch_async(q, ^{
            
        });
    };
    
    dispatch_async(q, task);
}

@end
