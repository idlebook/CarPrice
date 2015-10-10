//
//  PCCarCell.m
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import "PCCarCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PCCar.h"
#import "PCCCar.h"

@interface PCCarCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

@end

@implementation PCCarCell

//- (void)setCar:(PCCar *)car
//{
//    _car = car;
//    self.brandLabel.text = car.brandName;
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:car.imageSrc] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
//}

- (void)setCar:(PCCCar *)car
{
    _car = car;
    self.imageV.image = [UIImage imageNamed:car.icon];
    self.brandLabel.text = car.name;
}

@end
