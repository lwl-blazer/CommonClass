//
//  ShowViewController.m
//  TextObject
//
//  Created by blazer on 2018/11/16.
//  Copyright © 2018年 com.calabashboy. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    /**
     * UITraitEnvironment
     * iOS接口环境包括诸如横向和纵向尺寸、显示比例和用户界面习惯用法等
     */
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
}

- (void)buttonAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"Hello" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
