//
//  PCCarViewController.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCCarViewController.h"
#import "PCPageControl.h"


@interface PCCarViewController ()

@property (nonatomic, strong) NSMutableArray *images; /**< 轮播器图片 */

@end

@implementation PCCarViewController
#pragma mark - lazy
// 轮播器数据
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        for (int i  = 1; i <= 5; i++) {
            NSString *str = [NSString stringWithFormat:@"img_%02d", i];
            [_images addObject:str];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPageControl];
   
}

- (void)setupPageControl
{
    PCPageControl *pageView = [PCPageControl pageWithControl];
    pageView.images = self.images;
    

    self.tableView.tableHeaderView = pageView;
}

#pragma mark -tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"1";
    return cell;
}
@end
