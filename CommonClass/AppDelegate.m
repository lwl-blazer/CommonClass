//
//  AppDelegate.m
//  CommonClass
//
//  Created by blazer on 2017/8/25.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "AppDelegate.h"
#import "SvTestObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   // [self testNoRepeatTimer];
    [self testRepeatTimer];
    
}

- (void)testNoRepeatTimer{
    NSLog(@"Test Retain target for no-repeat timer!");
    
    SvTestObject *testObject = [[SvTestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:5 target:testObject selector:@selector(timerAction:) userInfo:nil repeats:NO];
    testObject = nil;
//    就算你把testObject写成nil了，这个定时器也不会停止执行方法， 所以说明NSTimer retain了调用方法的对象
    NSLog(@"InVoke release to testObject");
}

- (void)testRepeatTimer{
    NSLog(@"Test Retain target for repeat Timer");
    SvTestObject *testObject2 = [[SvTestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:5 target:testObject2 selector:@selector(timerAction:) userInfo:nil repeats:YES];
    testObject2 = nil;
    //    就算你把testObject写成nil了，这个定时器也不会停止执行方法， 所以说明NSTimer retain了调用方法的对象   所在就造成如果你在dealloc里写[_timer invalidate]的话，是永远不会执行
    NSLog(@"Invoke release to testObject2");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
