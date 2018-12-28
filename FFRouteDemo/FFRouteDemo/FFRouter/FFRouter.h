//
//  FFRouter.h
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FFRouteURLData.h"
#import "FFURLPath.h"
#import "FFWebViewController.h"

@interface FFRouter : NSObject
+ (instancetype)shared;
+ (void)start;
- (void)openUrl:(NSURL *)url withData:(NSDictionary *)data;

@end

