//
//  PCTabBarController.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCTabBarController.h"
#import "PCCarViewController.h"
#import "PCMoreViewController.h"
#import "PCSaleViewController.h"
#import "PCSearchViewController.h"
#import "PCToolsViewController.h"
#import "PCNavgationController.h"

@interface PCTabBarController ()

@end

@implementation PCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置Item属性
    [self setupItem];
    
    // 添加所有的子控制器
    [self setupChildVcs];
    
}

/**
 *  添加所有的子控制器
 */
- (void)setupChildVcs
{
    [self setupChildVc:[[PCCarViewController alloc] init] title:@"车型" image:@"tab_car" selectedImage:@"tab_car_b"];
    
    [self setupChildVc:[[PCSearchViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"找车" image:@"tab_Search" selectedImage:@"tab_Search_b"];
    
    [self setupChildVc:[[PCToolsViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"工具" image:@"tab_tools" selectedImage:@"tab_tools_b"];
    
    [self setupChildVc:[[PCSaleViewController alloc] init] title:@"降价" image:@"tab_sale" selectedImage:@"tab_sale_b"];
    
    [self setupChildVc:[[PCMoreViewController alloc] init] title:@"更多" image:@"tab_more" selectedImage:@"tab_more_b"];
      
}

/**
 *  添加一个子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 包装一个导航控制器
    PCNavgationController *nav = [[PCNavgationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
}

/**
 *  设置item属性
 */
- (void)setupItem
{
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = PCColor(220, 51, 0);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
