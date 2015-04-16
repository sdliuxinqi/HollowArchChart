//
//  HollowArchChart.h
//  ChartDemo
//
//  Created by LiuXinQi on 15/4/13.
//  Copyright (c) 2015年 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HollowArchChart : UIView

/*
 * @param
 * @{percentage:title,······}
 * @example: @{@60:@"part1", @40:@"part2", @70:@"part3", @10:@"part4"}
 */
@property (strong, nonatomic) NSDictionary *propotion;
@property (assign, nonatomic) CGPoint center;
@property (assign, nonatomic) CGFloat radius;

- (instancetype)initWithPropotion:(NSDictionary *)propotion center:(CGPoint)center radius:(CGFloat)radius;
@end
