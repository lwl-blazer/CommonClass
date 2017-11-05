//
//  BLCustomeAlertView.m
//  CommonClass
//
//  Created by blazer on 2017/11/4.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "BLCustomeAlertView.h"
#import "UIImage+CommonExtension.h"
#import "NSString+BLCommonExtention.h"
#import "UIView+BLExtention.h"


#define BLMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define BLMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define BLMainScreenBounds [UIScreen mainScreen].bounds
#define BLColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0  blue:(b) / 255.0  alpha:a]


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

@property(nonatomic, weak) UIButton *actionButton;

@property(nonatomic, weak) UIButton *cancelButton;

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

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message {
    BLCustomeAlertView *alertView = [[[self class] alloc] init];
    alertView.title = title;
    alertView.message = message;
    
    return alertView;
}

#pragma mark --- Public Method ----

+ (BLCustomeAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle defaultButtonTitle:(NSString *)defaultButtonTitle handler:(void (^)(BLCustomeAlertView *, NSInteger))block{
    BLCustomeAlertView *alertView = [[BLCustomeAlertView alloc] initWithTitle:title andMessage:message];
    
    return alertView;
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
    titleLabel.textAlignment = NSTextAlignmentCenter;
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
    
    UIButton *actionbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [actionbutton setTitleColor:self.defaultButtonTitleColor forState:UIControlStateNormal];
    actionbutton.titleLabel.font = self.buttonFont;
    [actionbutton addTarget:self action:@selector(actionButtonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [actionbutton setBackgroundImage:[UIImage bl_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [actionbutton setBackgroundImage:[UIImage bl_imageWithColor:BLColorAlpha(230, 230, 230, 0.5)] forState:UIControlStateHighlighted];
    [self.containerView addSubview:actionbutton];
    
    self.actionButton = actionbutton;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = self.buttonFont;
    [cancelBtn addTarget:self action:@selector(actionButtonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:[UIImage bl_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage bl_imageWithColor:BLColorAlpha(230, 230, 230, 0.5)] forState:UIControlStateHighlighted];
    [self.containerView addSubview:cancelBtn];
    self.cancelButton = cancelBtn;
}


//布局
- (void)setLayoutSuberViews{
    CGFloat margin = 25.0;
    CGFloat horizontalMargin = 65.0;
    
    if ([[NSString bl_deviceType] isEqualToString:iPhone6_6s_7]) {
        horizontalMargin = 45.0;
    }
    if ([[NSString bl_deviceType] isEqualToString:iPhone6_6s_7Plus]) {
        horizontalMargin = 60.0;
    }
    
    CGFloat containerViewWidth = BLMainScreenWidth - horizontalMargin * 2;
    
    //titleLabel
    CGSize titleLabelSize = {0, 0};
    if (self.title.length > 0) {
        titleLabelSize = [self.title bl_sizeWithSystemFont:self.titleFont constrainedToSize:CGSizeMake(containerViewWidth, MAXFLOAT)];
    }
    [self.titleLabel setFrame:CGRectMake(margin, margin, titleLabelSize.width, titleLabelSize.height)];
    
    //messageLabel
    CGSize messageLabelSize = {};
    if (self.message.length > 0) {
        messageLabelSize = [self.message bl_sizeWithSystemFont:self.messageFont constrainedToSize:CGSizeMake(containerViewWidth, MAXFLOAT)];
    }
    [self.messageLabel setFrame:CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame), messageLabelSize.width, messageLabelSize.height)];
    
    //line
    CALayer *vertialLine = [CALayer layer];
    vertialLine.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), containerViewWidth, 1);
    vertialLine.backgroundColor = [UIColor grayColor].CGColor;
    [self.containerView.layer addSublayer:vertialLine];
    
    
    //button
    
    self.cancelButton.frame = CGRectMake(margin, CGRectGetMaxY(self.messageLabel.frame) + 1, containerViewWidth / 2 - 1, 50);
    
    CALayer *horizonLine = [CALayer layer];
    horizonLine.backgroundColor = [UIColor grayColor].CGColor;
    horizonLine.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame), self.cancelButton.origin_y, 1, self.cancelButton.size_height);
    [self.containerView.layer addSublayer:horizonLine];
    
    self.actionButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame), self.cancelButton.origin_y, self.cancelButton.size_width, self.cancelButton.size_height);
    
   //containLabel
    self.containerLabelView.frame = CGRectMake(0, 0, containerViewWidth, CGRectGetMaxY(self.messageLabel.frame));
    
    //containView
    self.containerView.frame = CGRectMake(0, 0, containerViewWidth, CGRectGetMaxY(self.actionButton.frame));
    
    
    self.effectView.frame = self.containerView.bounds;
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


//button的处理事件
- (void)actionButtonTarget:(UIButton *)sender{
    if (sender == self.actionButton) {
        
    }
    
    if (sender == self.cancelButton) {
        
    }
}


#pragma mark ---- Setter and Getter ----

- (BLAlertWindow *)alertWindow{
    return nil;
}

- (void)setTitle:(NSString *)title{
    if (_title == title) {
        return;
    }
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message{
    if (_message == message) {
        return;
    }
    _message = message;
    self.messageLabel.text = message;
}


- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor{
    if (_viewBackgroundColor == viewBackgroundColor) {
        return;
    }
    _viewBackgroundColor = viewBackgroundColor;
    self.containerView.backgroundColor = viewBackgroundColor;
}

- (void)setTitleColor:(UIColor *)titleColor{
    if (_titleColor == titleColor) {
        return;
    }
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor{
    if (_messageColor == messageColor) {
        return;
    }
    
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setDefaultButtonTitleColor:(UIColor *)defaultButtonTitleColor{
    if (_defaultButtonTitleColor == defaultButtonTitleColor) {
        return;
    }
    
    _defaultButtonTitleColor = defaultButtonTitleColor;
    [self.actionButton setTitleColor:defaultButtonTitleColor forState:UIControlStateNormal];
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor{
    if (_cancelButtonTitleColor == cancelButtonTitleColor) {
        return;
    }
    _cancelButtonTitleColor = cancelButtonTitleColor;
    
    [self.cancelButton setTitleColor:cancelButtonTitleColor forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)titleFont{
    if (_titleFont == titleFont) {
        return;
    }
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setMessageFont:(UIFont *)messageFont{
    if (_messageFont == messageFont) {
        return;
    }
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
}


- (void)setButtonFont:(UIFont *)buttonFont{
    if (_buttonFont == buttonFont) {
        return;
    }
    _buttonFont = buttonFont;
    self.actionButton.titleLabel.font = buttonFont;
    self.cancelButton.titleLabel.font = buttonFont;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    if (_cornerRadius == cornerRadius) {
        return;
    }
    _cornerRadius = cornerRadius;
    self.containerView.layer.cornerRadius = cornerRadius;
}


@end
