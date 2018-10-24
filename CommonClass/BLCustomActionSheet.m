//
//  BLCustomActionSheet.m
//  MorSearchProject
//
//  Created by morsearch on 2017/9/28.
//  Copyright © 2017年 morsearch. All rights reserved.
//

#import "BLCustomActionSheet.h"
#import <Masonry/Masonry.h>
//16位颜色
#define HEXColor(hexValue,alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]

@interface BLCustomActionSheet ()

@property(nonatomic, weak) UIView *bgView;

@property(nonatomic, strong) UIWindow *backWindow;

@property(nonatomic, assign) CGFloat bgViewHeight;



@end

@implementation BLCustomActionSheet



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        [self setBackgroundColor:HEXColor(0x000000, 0)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissCustomActionSheet)];
        [self addGestureRecognizer:tap];
                
    }
    return self;
}

#pragma mark ----- Public Method -----
+ (instancetype) createActionSheet{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (void)showCustomActionSheet{
    
    NSAssert(self.bgView != nil, @"Please configure contentView");
    
    if (self.supView == nil) {
        self.backWindow.hidden = NO;
        [self.backWindow addSubview:self];
    }else{
        [self.supView addSubview:self];
    }
    
    
    [self layerAnimationMakeWithUP:YES];
    //执行布局
    [self.bgView.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if(@available(iOS 11.0, *)){
                make.top.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).with.offset(-self.bgViewHeight);
            }else{
                make.top.mas_equalTo(self.mas_bottom).with.offset(-self.bgViewHeight);
            }

        }];
        //强制绘制
        [self.bgView.superview layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.delegate && [self.delegate respondsToSelector:@selector(successShowed)] ? [self.delegate successShowed] : nil;
    }];
}

- (void)dismissCustomActionSheet{
    [self layerAnimationMakeWithUP:NO];
    [UIView animateWithDuration:0.15 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_bottom);
        }];
        [self.bgView.superview layoutIfNeeded];
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if (!self.supView) {
            [self.backWindow resignKeyWindow];
            self.backWindow.hidden = YES;
        }

        self.delegate && [self.delegate respondsToSelector:@selector(dismissed)] ? [self.delegate dismissed] : nil;
    }];
    
}

#pragma mark ----- Events Response ----

- (void)layoutContentView{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.mas_safeAreaLayoutGuideBottom);
        }else{
            make.top.equalTo(self.mas_bottom);
        }
        make.left.right.equalTo(self);
        make.height.mas_equalTo(self.bgViewHeight);
    }];
}

- (void)layerAnimationMakeWithUP:(BOOL)up{
    [self.layer removeAllAnimations];
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    if (up) {
        colorAnimation.duration = 0.3;
        colorAnimation.fromValue = (__bridge id _Nullable)([HEXColor(0x000000, 0) CGColor]);
        colorAnimation.toValue = (__bridge id _Nullable)([HEXColor(0x000000, 0.2) CGColor]);
    }else{
        colorAnimation.duration = 0.15;
        colorAnimation.fromValue = (__bridge id _Nullable)([HEXColor(0x000000, 0.2) CGColor]);
        colorAnimation.toValue = (__bridge id _Nullable)([HEXColor(0x000000, 0) CGColor]);
    }
    
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:colorAnimation forKey:@"colorAnimation"];
    
}

#pragma mark ---- Setter and Getter ----

- (UIWindow *)backWindow{
    if (!_backWindow) {
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel = UIWindowLevelAlert;
        [_backWindow becomeKeyWindow];
        [_backWindow makeKeyWindow];
    }
    return _backWindow;
}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    self.bgView = contentView;
    self.bgViewHeight = CGRectGetHeight(contentView.frame);
    
    if (self.bgViewHeight == 0) {
        self.bgViewHeight = self.contentViewHeight;
    }
    
    [self addSubview:self.bgView];
    [self layoutContentView];
}

@end
