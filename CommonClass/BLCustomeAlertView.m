//
//  BLCustomeAlertView.m
//  CommonClass
//
//  Created by blazer on 2017/11/4.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "BLCustomeAlertView.h"

#define BLMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define BLMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define BLMainScreenBounds [UIScreen mainScreen].bounds

#pragma mark ---- AlertViewItem -----

@interface BLAlertViewItem: NSObject

/** 按钮标题 */
@property (nonatomic, copy) NSString *title;
/** 按钮风格 */
@property (nonatomic, assign) HDAlertViewButtonType type;

@end

@implementation BLAlertViewItem

@end

#pragma mark ---- BLAlertWindow ------

@interface BLAlertWindow : UIWindow

@property(nonatomic, assign) NSInteger style;

@end

@implementation BLAlertWindow

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.style = 0;
        self.opaque = NO;
        self.windowLevel = 1899.0; // 不重叠系统的Alert, Alert的层级.
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[[UIColor blackColor] colorWithAlphaComponent:0.2] set];
    CGContextFillRect(context, self.bounds);
}

@end


#pragma mark ---- BLCustomeAlertView ----

@interface BLCustomeAlertView ()

/** Label容器视图 */
@property (nonatomic, weak) UIView *containerLabelView;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 消息描述 */
@property (nonatomic, weak) UILabel *messageLabel;
/** 容器视图 */
@property (nonatomic, weak) UIView *containerView;
/** 毛玻璃视图 */
@property (nonatomic, weak) UIVisualEffectView *effectView;

@property (nonatomic, strong) BLAlertWindow *alertWindow;

@end

@implementation BLCustomeAlertView


#pragma mark ---- init life ------

+ (void)initialize {
    if (self != [BLCustomeAlertView class]) return;
    
    BLCustomeAlertView *appearance = [self appearance]; // 设置整体默认外观
    appearance.viewBackgroundColor = [UIColor clearColor];
    appearance.titleColor = [UIColor blackColor];
    appearance.messageColor = [UIColor darkGrayColor];
    appearance.titleFont = [UIFont boldSystemFontOfSize:18.0];
    appearance.messageFont = [UIFont systemFontOfSize:16.0];
    appearance.buttonFont = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    appearance.defaultButtonTitleColor = [UIColor blueColor];
    appearance.cancelButtonTitleColor = [UIColor greenColor];
    appearance.destructiveButtonTitleColor = [UIColor redColor];
    appearance.cornerRadius = 10.0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = BLMainScreenBounds;
        [self setUpSubviews];
    }
    
    return self;
}

#pragma mark --- Events Response ----

- (void)setUpSubviews{
    /** 容器视图 */
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.layer.cornerRadius = self.cornerRadius;
    containerView.layer.masksToBounds = YES;
    [self addSubview:containerView];
    self.containerView = containerView;
    
    /** 毛玻璃视图 */
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self.containerView addSubview:effectView];
    self.effectView = effectView;
    
    /** Label容器视图 */
    UIView *containerLabelView = [[UIView alloc] init];
    containerLabelView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];;
    [containerView addSubview:containerLabelView];
    self.containerLabelView = containerLabelView;
    
    /** 标题 */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = self.titleFont;
    titleLabel.textColor = self.titleColor;
    titleLabel.numberOfLines = 0;
    [self.containerLabelView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** 消息描述 */
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = self.messageFont;
    messageLabel.textColor = self.messageColor;
    messageLabel.numberOfLines = 0;
    [self.containerLabelView addSubview:messageLabel];
    self.messageLabel = messageLabel;
}


//手势处理
/**
 *  滑动手势处理
 */
- (void)panPressContainerView:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            //隐藏
            break;
        }
            
        default:
            break;
    }
}
@end
