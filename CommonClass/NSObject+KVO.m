//
//  NSObject+KVO.m
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>


@implementation NSObject (KVO)

- (void)bl_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    
    //1.动态生成一个类
    NSString *oldClassName =  NSStringFromClass([self class]);
    NSString *newClassName = [@"BLKVO" stringByAppendingString:oldClassName];
    const char *name = [newClassName UTF8String];
    
    //2.定义一个类
    //第一个参数  继承于谁   第二个参数是名字  第三个参数直接给0
   Class myClass = objc_allocateClassPair([self class], name, 0);
    //2.1注册这个类
    objc_registerClassPair(myClass);
    
    //3.改变isa指针
    object_setClass(self, myClass);
    
    //4.重写setter方法（有没有必须添加setName方法,在底层编码的时候，继承的话是找的父类的，其实子类没有这个方法）   (重写方法)
    //后面三个参数   SEL方法编号 IMP方法实现(函数的指针)  types:可以随便写，但是也有意义(v返回值是void@OC对象:SEL类型@OC对象)
    //SEL方法编号  ----- IMP方法实现  ---通过函数指针----  代码块
    class_addMethod(myClass, @selector(setName:), (IMP)setName, "v@:@");
    
    //5.保存观察者 就是绑定  第二个参数是一个指针，呆会就用这个指针来通知  @"blazer"是一个指针常量
    objc_setAssociatedObject(self, (__bridge const void*)@"blazer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


//方法实现   外面赋值传过来的参数    所有的OC方法的调用都是前面都有两个隐式参数 第一个方法的调用者，第二个方法编号
void setName(id self, SEL _cmd, NSString *newName){
    
    //0.保存当前Class
    id class = [self class];
    //1.将self类型换成父类
    object_setClass(self, class_getSuperclass([self class]));
    //1.调用父类的setName方法
    objc_msgSend(self, @selector(setName:), newName);
    
    //3.拿出观察者
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"blazer");
    //4.通知外界
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), @"hello", nil, nil);
    //5.改回子类
    object_setClass(self, class);
    
}

@end
