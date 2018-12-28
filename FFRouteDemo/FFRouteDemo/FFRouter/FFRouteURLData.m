//
//  FFRouteURLData.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "FFRouteURLData.h"

@implementation FFRouteURLData

+ (instancetype)urlDataWithUrl:(NSURL *)url;{
    FFRouteURLData *a =  [[self alloc] init];
    a.URL = url;
    return a;
}

- (NSURL *)URL{
    if (!_URL) {
        _URL = [NSURL URLWithString:@"app://"];
    }
    return _URL;
}
- (NSString *)routeType{
    if (self.URL.host&&[self.URL.host isEqualToString:@"open"]) {
        return @"open";
    }
    return @"";
}

- (NSString *)controllerName{
    NSString *path =self.URL.path.length>0?[self.URL.path substringFromIndex:1]:@"";
    return path;
}

- (NSDictionary *)data{
    NSString *dataStr = [NSString stringWithFormat:@"%@",self.URL.query];
    NSArray *keyValues = [dataStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = @{}.mutableCopy;
    [keyValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:[obj componentsSeparatedByString:@"="].lastObject forKey:[obj componentsSeparatedByString:@"="].firstObject];
    }];
    return dic;
}

@end
