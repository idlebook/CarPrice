//
//  PCNetworkTools.m
//
//  Created by 聪 on 14/8/19.
//  Copyright © 2014年 西哥晚风轻吹. All rights reserved.
//

#import "PCNetworkTools.h"

@implementation PCNetworkTools
+ (instancetype)shareNetworkTools
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 注意: 在指定baseURL的时候, 后面需要加上/
        NSURL *url = [NSURL URLWithString:@"http://api2.juheapi.com/carzone/car/"];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return instance;
}
@end
