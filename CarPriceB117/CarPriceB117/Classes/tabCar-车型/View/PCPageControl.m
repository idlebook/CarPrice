//
//  PCPageControl.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCPageControl.h"

@interface PCPageControl ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *sc;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer; /**< 定时器 */


@end

@implementation PCPageControl

- (instancetype)initWithPageControl
{
    return [PCPageControl viewFromXib];
}

+ (instancetype)pageWithControl
{
    return [[self alloc] initWithPageControl];
}

- (void)awakeFromNib
{
    self.sc.bounces = NO;
    self.sc.showsHorizontalScrollIndicator = NO;
    self.sc.showsVerticalScrollIndicator = NO;
    self.sc.pagingEnabled = YES;
    
    self.sc.delegate = self;
    [self.pageControl addTarget:self action:@selector(pageControlClick) forControlEvents:UIControlEventValueChanged];
    
    [self startTimer];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    for (int i = 0; i < _images.count; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.image = [UIImage imageNamed:_images[i]];
        [self.sc addSubview:iv];
    }
    self.pageControl.numberOfPages = _images.count;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.sc.subviews enumerateObjectsUsingBlock:^(UIImageView *imageV, NSUInteger idx, BOOL *stop) {
        
        imageV.frame = CGRectMake(self.sc.width * idx , 0, self.sc.width, self.sc.height);

    }];
    
    self.sc.contentSize = CGSizeMake(self.sc.width * self.images.count, self.sc.height);
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerWithPageChage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 自动更改页码
- (void)timerWithPageChage
{
    self.pageControl.currentPage = (self.pageControl.currentPage + 1 ) % self.images.count;
    [self pageControlClick];
}

// 页面内容随着页数更改
- (void)pageControlClick
{
    self.sc.contentOffset = CGPointMake(self.sc.width * self.pageControl.currentPage, 0);
}

// 拖拽内容,更改页数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.sc.contentOffset.x / self.sc.width + 0.5;
}

// 拖拉销毁定时器
- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView
{
    [self.timer invalidate];
}

// 结束拉拽,启动定时器
- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
@end
