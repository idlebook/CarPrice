//
//  PCCarViewController.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCCarViewController.h"
#import "PCCarHeader.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PCCar.h"
#import "PCCarCell.h"

@interface PCCarViewController ()
@property (nonatomic, strong) NSMutableArray *cars; /**< 汽车 */
@property (nonatomic, weak) PCNetworkTools *manager; /**< 请求管理者 */
@end

@implementation PCCarViewController
static NSString *const PCCarCellId = @"PCCarCell";

#pragma mark -lazy
- (PCNetworkTools *)manager
{
    if (!_manager) {
        _manager = [PCNetworkTools shareNetworkTools];
    }
    
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PCCarCell class]) bundle:nil] forCellReuseIdentifier:PCCarCellId];
    self.tableView.rowHeight = 60;
    
    
    [self setupPageControl];
   
    [self setupRefresh];
}

#pragma mark - 初始化
- (void)setupPageControl
{
    PCCarHeader *carHeader = [PCCarHeader carHeader];
    
    self.tableView.tableHeaderView = carHeader;
}


- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCars)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header beginRefreshing];

}

// 下拉刷新
- (void)loadNewCars
{
    // 取消之前的刷新请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    PCWeakSelf;
    [self.manager GET:@"brand/list" parameters:@{@"key" : @"4a77895cf28871e6892b3fb556dc2705"} success:^(NSURLSessionDataTask *task , id responseObject ) {
        // 字典转模型
        weakSelf.cars = [PCCar objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task , NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
        } else {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }
    }];
}


#pragma mark -tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCCarCell *cell = [tableView dequeueReusableCellWithIdentifier:PCCarCellId];
    
    PCCar *car = self.cars[indexPath.row];
    cell.car = car;

    return cell;
}

#pragma mark - tableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"A";
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"];
}
@end
