//
//  ViewController.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "ViewController.h"
#import "FFRouter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1级页面";
    
}

//内部路由
- (IBAction)urlOpenPage1:(UIButton *)sender {
    id block = ^(NSString *str){
        NSLog(@"返回====%@",str);
    };
    NSDictionary *dic = @{
                          @"name":@"我的名字叫‘大神’",
                          @"callBack":block
                          };
    [[FFRouter shared] openUrl:[NSURL URLWithString:@"FFApp://open/detail"] withData:dic];
}

//h5跳转路由
- (IBAction)urlOpenPage:(UIButton *)sender {
    id block = ^(NSString *str){
        NSLog(@"返回====%@",str);
    };
    NSDictionary *dic = @{
                          @"contentString":@"h5叫我打开这个页面的，‘大神’ ",
                          @"callBack":block
                          };
    [[FFRouter shared] openUrl:[NSURL URLWithString:@"FFhttp://open/test/second"] withData:dic];
    
}

//纯网页
- (IBAction)urlOpenPage2:(UIButton *)sender {
    [[FFRouter shared] openUrl:[NSURL URLWithString:@"http://www.baidu.com"] withData:nil];
}



@end
