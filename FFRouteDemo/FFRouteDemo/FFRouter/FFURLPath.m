//
//  FFURLPath.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "FFURLPath.h"

@implementation FFURLPath

+ (instancetype)shared;{
    static FFURLPath *a = nil;
    if (!a) {
        a = [[FFURLPath alloc] init];
    }
    return a;
}

- (NSMutableDictionary *)registDict{
    if (!_registDict) {
        _registDict = @{}.mutableCopy;
    }
    return _registDict;
}

- (void)registClass:(NSString *)className withPath:(NSString *)path;{
    if (!className||className.length==0) {
        return;
    }
    if (!path||path.length==0) {
        [self removePathRegist:className];
        return;
    }
    [self.registDict setObject:className forKey:path];
}

- (void)removePathRegist:(NSString *)className;{
    if (!className||className.length==0) {
        return;
    }
    
    __block NSString *removeKey = nil;
    [self.registDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:className]) {
            removeKey = key;
            *stop = YES;
        }
    }];
    if (removeKey) {
        [self.registDict removeObjectForKey:removeKey];
    }
}

- (void)registerDefaultRouteList {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FFRouteList" ofType:@"plist"]];
    for (NSDictionary *dic in array) {
        [self registClass:dic[@"VCName"] withPath:dic[@"path"]];
    }
}

@end
