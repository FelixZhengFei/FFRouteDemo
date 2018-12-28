//
//  SecondeVC.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "SecondeVC.h"
#import "FFRouter.h"

@interface SecondeVC ()
@property (weak, nonatomic) IBOutlet UILabel *contectLabel;

@end

@implementation SecondeVC

+(void)load{
    [[FFURLPath shared] registClass:NSStringFromClass(self.class) withPath:@"second"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大吉大利";
    self.contectLabel.text = self.contentString;
}

@end
