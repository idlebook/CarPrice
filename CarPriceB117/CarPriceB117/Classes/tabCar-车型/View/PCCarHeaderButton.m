//
//  PCCarHeaderButton.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCCarHeaderButton.h"

@implementation PCCarHeaderButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片的位置和尺寸
    self.imageView.y = 0;
    self.imageView.width = 50;
    self.imageView.height = 50;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字的位置和尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 7;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

//- (void)setHighlighted:(BOOL)highlighted
//{
//    
//}
@end
