//
//  CustomAlertViewController.m
//  TextObject
//
//  Created by luowailin on 2018/11/22.
//  Copyright © 2018 com.calabashboy. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];

}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    self.preferredContentSize = CGSizeMake(270, 270);
}

@end
