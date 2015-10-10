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
#import "PCCCar.h"
#import "PCCarGroup.h"

@interface PCCarViewController ()
@property (nonatomic, strong) NSMutableArray *carss; /**< 汽车 */
@property (nonatomic, weak) PCNetworkTools *manager; /**< 请求管理者 */
@property (nonatomic, strong) NSMutableArray *carGroup; /**< plist测试数据 */
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
    
    [self setupPageControl];
   
    [self setupTable];
    
    [self setupRefresh];
}

#pragma mark - 初始化
- (void)setupTable
{
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PCCarCell class]) bundle:nil] forCellReuseIdentifier:PCCarCellId];
}

- (void)setupPageControl
{
    PCCarHeader *carHeader = [PCCarHeader carHeader];
    UIView *vc = [[UIView alloc] init];
    vc.width = carHeader.width;
    vc.height = carHeader.height;
    [vc addSubview:carHeader];
    self.tableView.tableHeaderView = vc;
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
        weakSelf.carss = [PCCar objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
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

#pragma mark - 网络请求数据不合规,由本地加载
- (NSMutableArray *)carGroup
{
    if (!_carGroup) {
        [PCCarGroup setupObjectClassInArray:^NSDictionary *{
            return @{@"cars" : @"PCCCar"};
        }];
        _carGroup = [PCCarGroup objectArrayWithFilename:@"cars.plist"];
    }
    
    return _carGroup;
}

#pragma mark -tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PCCarGroup *group = self.carGroup[section];
    
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCCarCell *cell = [tableView dequeueReusableCellWithIdentifier:PCCarCellId];
    
    PCCarGroup *group = self.carGroup[indexPath.section];
    PCCCar *car = group.cars[indexPath.row];
    cell.car = car;

    return cell;
}

#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = nil;
    UIView *view = nil;
    static NSString *ID = @"header";
    static NSInteger tag = 99;
    static NSInteger tag1 = 999;
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) { // 缓存池中没有header
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        
        label = [[UILabel alloc] init];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.x = 8;
        label.tag = tag;
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        [header addSubview:label];
        
        view = [[UIView alloc] init];
        view.frame = CGRectMake(8, 19, PCScreenW, 0.5);
        view.backgroundColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:0.5];
        view.tag = tag1;
        [header addSubview:view];

    } else { // 从缓存池中获取, header本身就有label
        label = (UILabel *)[header viewWithTag:tag];
        view = (UIView *)[header viewWithTag:tag];
    }
    
    PCCarGroup *group = self.carGroup[section];
    label.text = group.title;
    label.textColor = [UIColor grayColor];
    
    return header;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.carGroup valueForKey:@"title"];
}

#warning 跳转每个cell的界面,待完成
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCLogFunc;
}

@end
