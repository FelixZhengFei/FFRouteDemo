//
//  AppDelegate.m
//  FFRouteDemo
//
//  Created by 郑强飞 on 2018/12/28.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "AppDelegate.h"
#import "FFRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FFRouter start];
    return YES;
}



@end
