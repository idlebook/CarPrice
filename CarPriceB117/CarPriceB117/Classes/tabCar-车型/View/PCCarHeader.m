//
//  PCCarHeader.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCCarHeader.h"
#import "PCPageControl.h"


@interface PCCarHeader ()
@property (nonatomic, strong) NSMutableArray *images; /**< 轮播器图片 */
@property (weak, nonatomic) IBOutlet PCPageControl *pageControl;
@end

@implementation PCCarHeader
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

+ (instancetype)carHeader
{
    return [PCCarHeader viewFromXib];
}

- (void)awakeFromNib
{
    self.pageControl.images = self.images;
}


@end
