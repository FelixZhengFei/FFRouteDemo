//
//  FFRouteURLData.h
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFRouteURLData : NSObject


/**路由类型*/
@property (assign,nonatomic,readonly) NSString *routeType;
/**页面名*/
@property (copy,nonatomic,readonly) NSString *controllerName;
/**传递参数*/
@property (strong,nonatomic,readonly) NSDictionary *data;
/**原始URL*/
@property (strong,nonatomic) NSURL *URL;
/**便利构造*/
+ (instancetype)urlDataWithUrl:(NSURL *)url;

@end


