//
//  DetailViewController.h
//  FFRouterDemo
//
//  Created by 郑强飞 on 2018/12/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DetailViewController : UIViewController

@property (copy,nonatomic) NSString *name;

@property (nonatomic, copy)void (^callBack)(NSString *str);

@end


