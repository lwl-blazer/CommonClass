//
//  ViewController4.m
//  CommonClass
//
//  Created by luowailin on 2020/9/3.
//  Copyright © 2020 blazer. All rights reserved.
//

#import "ViewController4.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://web.bee2c.com/beeweb/sso/ms/MsSso?Token=301951dba93a4d3996fff1c72cfb0681&ApplyOrderNo=&MenuType=TrainBooking"]]];
////    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
//    [self.view addSubview:webView];
//
////    webView.UIDelegate = self;
//
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//        } else {
//            make.top.mas_offset(64);
//        }
//        make.leading.trailing.bottom.mas_offset(0);
//    }];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectZero];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://web.bee2c.com/beeweb/sso/ms/MsSso?Token=301951dba93a4d3996fff1c72cfb0681&ApplyOrderNo=&MenuType=TrainBooking"]]];
    [self.view addSubview:webview];
    
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_offset(64);
        }
        make.leading.trailing.bottom.mas_offset(0);
    }];
}



@end
