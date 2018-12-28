//
//  DetailViewController.m
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "DetailViewController.h"
#import "FFRouter.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DetailViewController

- (IBAction)click:(id)sender {
    if (self.callBack) {
        self.callBack(@"大神 教你写代码");
        
        NSDictionary *dic = @{
                              @"contentString":@"‘大神’ 还是那么6"
                              };
        [[FFRouter shared] openUrl:[NSURL URLWithString:@"FFApp://open/second"] withData:dic];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = self.name;
    self.title = @"详情";
}


@end
