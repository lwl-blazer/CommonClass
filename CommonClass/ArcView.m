
//
//  ArcView.m
//  CommonClass
//
//  Created by luowailin on 2019/10/16.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "ArcView.h"

@interface ArcView ()


@property(nonatomic, strong) CAShapeLayer *leftOvalLayer;
@property(nonatomic, strong) CAShapeLayer *rightOvalLayer;

@end

@implementation ArcView

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_leftOvalLayer == nil) {
        [self.layer addSublayer:self.leftOvalLayer];
    }
    
    if (_rightOvalLayer == nil) {
        [self.layer addSublayer:self.rightOvalLayer];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (CAShapeLayer *)leftOvalLayer{
    if (!_leftOvalLayer) {
        _leftOvalLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 10)];
        [path addArcWithCenter:CGPointMake(0, 10) radius:10
                    startAngle:0.5 * M_PI
                      endAngle:1.5 * M_PI
                     clockwise:NO];
        _leftOvalLayer.path = path.CGPath;
        _leftOvalLayer.fillColor = [UIColor redColor].CGColor;
    }
    return _leftOvalLayer;
}

- (CAShapeLayer *)rightOvalLayer{
    if (!_rightOvalLayer) {
        _rightOvalLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetMaxX(self.frame) - 8, 10)];
        [path addArcWithCenter:CGPointMake(CGRectGetMaxX(self.frame) - 8, 10) radius:10
                    startAngle:0.5 * M_PI
                      endAngle:1.5 * M_PI
                     clockwise:YES];
        _rightOvalLayer.path = path.CGPath;
        _rightOvalLayer.fillColor = [UIColor redColor].CGColor;
    }
    return _rightOvalLayer;
}

@end
