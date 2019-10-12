//
//  ViewController2.m
//  CommonClass
//
//  Created by luowailin on 2019/9/19.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@property(nonatomic, copy) NSString *path;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"path:%@", self.path);
    
}

- (instancetype)initWithPath:(NSString *)path{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.path = path;
    }
    return self;
}



@end
