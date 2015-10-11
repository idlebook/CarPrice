//
//  PCSaleViewController.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCSaleViewController.h"

@interface PCSaleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableViewSale;
@property (nonatomic, strong) UITableView *tableViewMeCh;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PCSaleViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUpViews];
    [self setUpTable];
}

//设置导航栏
- (void)setNav
{   //中间title视图
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    //按钮降价
    UIButton *saleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saleBtn.frame = CGRectMake(0, 0, 60, 30);
    [saleBtn setTitle:@"降价" forState:UIControlStateNormal];
    [saleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saleBtn setTitleColor:PCColor(227, 75, 9)  forState:UIControlStateSelected];
    saleBtn.tag = 10;
    saleBtn.layer.borderWidth = 1;
    saleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //按钮经销商
    UIButton *merchantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    merchantBtn.frame = CGRectMake(60, 0, 60, 30);
    [merchantBtn setTitle:@"经销商" forState:UIControlStateNormal];
    [merchantBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [merchantBtn setTitleColor:PCColor(227, 75, 9) forState:UIControlStateSelected];
    merchantBtn.tag = 20;
    merchantBtn.layer.borderWidth = 1;
    merchantBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [saleBtn addTarget:self action:@selector(slideTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [merchantBtn addTarget:self action:@selector(slideTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:saleBtn];
    [titleView addSubview:merchantBtn];
    [self slideTitleBtn:saleBtn];
    
    self.navigationItem.titleView = titleView;
    //右边barbutton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"广州" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

//设置主视图
- (void)setUpViews
{
    //滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 64, PCScreenW, PCScreenH - 64 - 49);
    scrollView.contentSize = CGSizeMake(PCScreenW * 2, scrollView.frame.size.height);
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //分类选择按钮
    NSArray *title = @[@"全部品牌",@"全部条件",@"智能排序",@"全部品牌",@"全部区域",@"智能排序"];
    for (int i = 0; i < title.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * PCScreenW / 3, 0, PCScreenW / 3, 30);
        //右边分隔线
        if (i != 2 && i != 5) {
            UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.size.width - 0.5, 0, 0.5, btn.frame.size.height)];
            rightLine.backgroundColor = [UIColor lightGrayColor];
            [btn addSubview:rightLine];
        }
        [self.scrollView addSubview:btn];
    }
    //底部分隔线
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, 2 * PCScreenW, 0.5)];
    buttomLine.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:buttomLine];
}

- (void)setUpTable
{
    UITableView *tableviewscale = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, PCScreenW, self.scrollView.frame.size.height)];
    self.tableViewSale = tableviewscale;
    tableviewscale.delegate = self;
    tableviewscale.dataSource = self;
    tableviewscale.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:tableviewscale];
    
    UITableView *tableviewmer = [[UITableView alloc] initWithFrame:CGRectMake(PCScreenW, 30, PCScreenW, self.scrollView.frame.size.height)];
    self.tableViewMeCh = tableviewmer;
    tableviewmer.delegate = self;
    tableviewmer.dataSource = self;
    tableviewmer.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:tableviewmer];
}

#pragma mark - 监听
- (void)leftBarClick
{
    
}
//切换标题
- (void)slideTitleBtn:(UIButton *)Btn
{
    //设置按钮状态
    Btn.selected = YES;
    Btn.backgroundColor = [UIColor whiteColor];
    UIButton *BtnOther = (UIButton *)[self.navigationItem.titleView viewWithTag:Btn.tag == 10 ? 20: 10];
    BtnOther.selected = NO;
    BtnOther.backgroundColor = PCColor(227, 75, 9);
    //移动scrollView内容
    CGFloat offsetX = (Btn.tag == 20) * PCScreenW;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 10;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
