//
//  UIView+Extension.h
//  CarPriceB117
//
//  Created by 聪 on 15/10/10.
//  Copyright (c) 2015年 B117. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x; /**< x */
@property (nonatomic, assign) CGFloat y; /**< y */
@property (nonatomic, assign) CGFloat centerX; /**< centerX */
@property (nonatomic, assign) CGFloat centerY; /**< centerY */
@property (nonatomic, assign) CGFloat width; /**< width */
@property (nonatomic, assign) CGFloat height; /**< height */
@property (nonatomic, assign) CGSize size; /**< size */
@property (nonatomic, assign) CGPoint origin; /**< origin */

+ (instancetype)viewFromXib;
@end
