//
//  BLCustomeAlertView.h
//  CommonClass
//
//  Created by blazer on 2017/11/4.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDAlertViewButtonType) {
    BLAlertViewButtonTypeDefault = 0,   // 字体默认蓝色
    BLAlertViewButtonTypeDestructive,   // 字体默认红色
    BLAlertViewButtonTypeCancel         // 字体默认绿色
};


typedef NS_ENUM(NSInteger, HDAlertViewTransitionStyle) {
    BLAlertViewTransitionStyleFade = 0,             // 渐退
    BLAlertViewTransitionStyleSlideFromTop,         // 从顶部滑入滑出
    BLAlertViewTransitionStyleSlideFromBottom,      // 从底部滑入滑出
    BLAlertViewTransitionStyleBounce,               // 弹窗效果
    BLAlertViewTransitionStyleDropDown              // 顶部滑入底部滑出
};


@class BLCustomeAlertView;
typedef void(^BLAlertViewHandler)(BLCustomeAlertView *alertView);

@interface BLCustomeAlertView : UIView

//标题
@property (nonatomic, copy) NSString *title;

//信息
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UIColor *viewBackgroundColor          UI_APPEARANCE_SELECTOR; // 默认是白色
@property (nonatomic, strong) UIColor *titleColor                   UI_APPEARANCE_SELECTOR; // 默认是黑色
@property (nonatomic, strong) UIColor *messageColor                 UI_APPEARANCE_SELECTOR; // 默认是灰色
@property (nonatomic, strong) UIColor *defaultButtonTitleColor      UI_APPEARANCE_SELECTOR; // 默认是白色
@property (nonatomic, strong) UIColor *cancelButtonTitleColor       UI_APPEARANCE_SELECTOR; // 默认是白色
@property (nonatomic, strong) UIColor *destructiveButtonTitleColor  UI_APPEARANCE_SELECTOR; // 默认是白色
@property (nonatomic, strong) UIFont *titleFont                     UI_APPEARANCE_SELECTOR; // 默认是18.0
@property (nonatomic, strong) UIFont *messageFont                   UI_APPEARANCE_SELECTOR; // 默认是16.0
@property (nonatomic, strong) UIFont *buttonFont                    UI_APPEARANCE_SELECTOR; // 默认是buttonFontSize
@property (nonatomic, assign) CGFloat cornerRadius                  UI_APPEARANCE_SELECTOR; // 默认是10.0

+ (BLCustomeAlertView *)showAlertViewWithTitle:(NSString *)title
                                       message:(NSString *)message
                             cancelButtonTitle:(NSString *)cancelButtonTitle
                            defaultButtonTitle:(NSString *)defaultButtonTitle
                                       handler:(void (^)(BLCustomeAlertView *alertView, NSInteger buttonIndex))block;

@end
