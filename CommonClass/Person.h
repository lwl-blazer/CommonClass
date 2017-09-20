//
//  Person.h
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{

}

//在ARC的情况 block用strong和copy没有区别
//block属性
//@property(nonatomic, strong) void (^run)();

//返回方法本身
- (instancetype)eat;

- (Person *(^)(int m))run;


//KVO   isa指针伪装指向父类  如果不用属性，如果是成员变量的话，就是观察不到
@property(nonatomic, copy) NSString *name;




@end
