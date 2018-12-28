//
//  FFWebViewController.h
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

// WKWebView 内存不释放的问题解决
@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end



@interface FFWebViewController : UIViewController <WKNavigationDelegate,  WKUIDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) void(^closeBlock)(void);
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;


@end
