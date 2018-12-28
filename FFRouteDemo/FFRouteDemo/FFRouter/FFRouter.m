//
//  FFRouter.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import <objc/runtime.h>
#import "FFRouter.h"
#import "FFRouteURLData.h"
#import "FFURLPath.h"
#import "FFWebViewController.h"

@implementation FFRouter

UIViewController * _Nonnull y_currentController(){
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *w in windows) {
            if (w.windowLevel==UIWindowLevelNormal) {
                window = w;
                break;
            }
        }
    }
    UIViewController * result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

UIViewController * _Nonnull y_controller(NSString *name){
    if (!name||name.length==0) {
        NSLog(@"路由错误1：%@",name);
        return nil;
    }
    if ([[FFURLPath shared].registDict objectForKey:name]) {
        name = [[FFURLPath shared].registDict objectForKey:name];
    } else {
        NSLog(@"路由错误2：%@",name);
        return nil;
    }
    id vc = [[NSClassFromString(name) alloc] init];
    if (vc) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            return vc;
        }
        NSString *error = [NSString stringWithFormat:@"Class %@不是controller",name];
        NSLog(@"路由错误3：%@",error);
        return nil;
    } else {
        NSString *error = [NSString stringWithFormat:@"Class %@不存在",name];
        NSLog(@"路由错误4：%@",error);
        return nil;
    }
}

+ (void)start {
    [[FFURLPath shared] registerDefaultRouteList];
}

+ (instancetype)shared;{
    static FFRouter *route = nil;
    if (!route) {
        route = [[FFRouter alloc] init];
    }
    return route;
}

//处理app间的通信、跳转等事件
- (void)openUrl:(NSURL *)url withData:(NSDictionary *)data {
    
    // 1内部路由 FFRouterDemo://open/...
    if ([@"FFApp" isEqual: url.scheme]) {
        FFRouteURLData *urlData = [FFRouteURLData urlDataWithUrl:url];
        if ([@"open" isEqual: urlData.routeType]) {
            [self pushVcName:urlData.controllerName from:nil withData:data];
        } else {
            NSLog(@"路由错误0：%@",url);
        }
        
        // 2 纯网页由 http://...  https://...
    } else if ([@"http" isEqual: url.scheme] || [@"https" isEqual: url.scheme]) {
        NSString *scheme = url.scheme;
        // 2.1 打开外部连接
        if ([scheme hasPrefix:@"item"]) {
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
                return ;
            }
        } else {
            NSString *webURL = url.absoluteString;
            if(!webURL){
                return;
            }
            FFWebViewController *webView;
            webView = [[FFWebViewController alloc] init];
            webView.webURL = webURL;
            [self push:webView from:nil withData:data];
        }
        
        // 3 h5内部路由 FFhttp://open  FFhttps://open/
    } else if ([@"FFhttp" isEqual: url.scheme] || [@"FFhttps" isEqual: url.scheme]) {
        FFRouteURLData *urlData = [FFRouteURLData urlDataWithUrl:url];
        if ([@"open" isEqual: urlData.routeType]) {
            [self configH5ToNativeMethod:url withData:data];
        } else {
            NSLog(@"内部路由：%@",url);
        }
        
    } else {
        NSLog(@"路由错误0：%@",url);
    }
}

/**配置h5 跳转 native 路由*/
- (void)configH5ToNativeMethod:(NSURL *)url withData:(NSDictionary *)data {
    NSArray *array = [url.path componentsSeparatedByString:@"/"];
    NSString *oneSring = @"";
    NSString *twoString = @"";
    if (array && array.count > 2) {
        oneSring = [array objectAtIndex:1];
        twoString = [array objectAtIndex:2];
    }
    if ([oneSring isEqualToString:@"test"]){
        if ([twoString isEqualToString:@"second"]) { //打开详情
            [self pushVcName:@"second" from:nil withData:data];
        }
    }
}

- (void)push:(UIViewController *)vc from:(UIViewController *)fromvc  withData:(NSDictionary *)data {
    UIViewController *a = fromvc?fromvc:y_currentController();
    if (!vc) {
        return;
    }
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        @try {
            [vc setValue:obj forKey:key];
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
    vc.hidesBottomBarWhenPushed = YES;
    [a.navigationController pushViewController:vc animated:YES];
}

- (void)present:(UIViewController *)vc from:(UIViewController *)fromvc  withData:(NSDictionary *)data;{
    UIViewController *a = fromvc?fromvc:y_currentController();
    if (!vc) {
        return;
    }
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        @try {
            [vc setValue:obj forKey:key];
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
    [a presentViewController:vc animated:YES completion:^{
    }];
}

//调用某个页面
- (void)pushVcName:(NSString *)vcName from:(UIViewController *)fromvc withData:(NSDictionary *)data{
    UIViewController *vc = y_controller(vcName);
    [self push:vc from:fromvc withData:data];
}

- (void)presentVcName:(NSString *)vcName from:(UIViewController *)fromvc withData:(NSDictionary *)data{
    UIViewController *vc = y_controller(vcName);
    [self present:vc from:fromvc withData:data];
}



@end
