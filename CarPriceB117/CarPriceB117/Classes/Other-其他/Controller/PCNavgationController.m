//
//  PCNavgationController.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCNavgationController.h"

@interface PCNavgationController ()

@end

@implementation PCNavgationController

+ (void)initialize
{
    // 设置整个项目导航栏的item的主题样式
    UINavigationBar *bar = [UINavigationBar appearance];
   
    [bar setBarTintColor:PCColor(228, 74, 5)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
