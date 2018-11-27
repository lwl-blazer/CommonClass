//
//  RootViewController.m
//  TextObject
//
//  Created by blazer on 2018/10/31.
//  Copyright © 2018年 com.calabashboy. All rights reserved.
//

#import "RootViewController.h"
#import "UIView+Effects.h"
#import "ShowViewController.h"
#import "PresentationController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"展开下面的" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(30, 100, 100, 30);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self add:button.bounds button:button];
    
    //button.conrnerRadius(10).borderWidth(1).borderColor([UIColor blueColor]).showVisual();
    //button.layer.mask = [self createCornerRadius:5.0 size:button.bounds.size borderColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)buttonAction{
    ShowViewController *showController = [ShowViewController new];
    
    PresentationController *presentController = [[PresentationController alloc] initWithPresentedViewController:showController presentingViewController:self];
    
    showController.transitioningDelegate = presentController;
    
    [self presentViewController:showController animated:YES completion:NULL];
    
    
}

- (CAShapeLayer *_Nullable)createCornerRadius:(CGFloat)cornerRadius
                                         size:(CGSize)size
                                  borderColor:(UIColor *_Nullable)borderColor{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, size.width, size.height);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    borderLayer.path = bezierPath.CGPath;
    return borderLayer;
}


- (void)add:(CGRect)bounds button:(UIButton *)btn{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                                     cornerRadii:CGSizeMake(5, 5)];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = path.CGPath;
    btn.layer.mask = maskLayer;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = bounds;
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    [btn.layer addSublayer:layer];
  
}

@end
