//
//  FFURLPath.h
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FFURLPath : NSObject

/**
 特殊路由标示注册字典
 */
@property (strong,nonatomic) NSMutableDictionary *registDict;

+ (instancetype)shared;

/**
 注册
 param className 页面类名
 param path 标示
 */
- (void)registClass:(NSString *)className withPath:(NSString *)path;

/**
 移除
 */
- (void)removePathRegist:(NSString *)className;

/**
 注册默认路由
 */
- (void)registerDefaultRouteList;
@end


