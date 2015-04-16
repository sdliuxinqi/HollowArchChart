//
//  HollowArchChart.m
//  ChartDemo
//
//  Created by LiuXinQi on 15/4/13.
//  Copyright (c) 2015年 yonyou. All rights reserved.
//

#import "HollowArchChart.h"


@implementation HollowArchChart
- (instancetype)initWithPropotion:(NSDictionary *)propotion center:(CGPoint)center radius:(CGFloat)radius
{
    NSArray *allKeys = [propotion allKeys];
    float total = 0;
    for (NSNumber *percentage in allKeys) {
        total += percentage.floatValue;
    }
    if (total != 100 || radius <= 0) {
        NSLog(@"propotion isn't match");
        return nil;
    }else{
        self.propotion = propotion;
        self.center = center;
        self.radius = radius;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    self.center = CGPointMake(150, 200);
    self.radius = 100;
    NSArray *colorArry = @[[UIColor redColor], [UIColor yellowColor], [UIColor blueColor], [UIColor purpleColor], [UIColor greenColor], [UIColor cyanColor], [UIColor magentaColor], [UIColor orangeColor]];
    self.propotion = @{@60:@"adsf", @40:@"iadg", @70:@"adsg", @10:@"asdfg"};
    
    NSArray *allKeys = [self.propotion allKeys];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lastValue = 0;
    for (int i = 0; i < allKeys.count; i++) {
        NSNumber *percentage = allKeys[i];
        NSString *title = [self.propotion objectForKey:percentage];
        UIColor *color = (UIColor *)colorArry[i];
        float part = percentage.floatValue;
        
        //draw sector
        CGContextSetAlpha(context, 0.6);
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, self.radius, -lastValue * M_PI/180 , (-part-lastValue) * M_PI/180, 1);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextDrawPath(context, kCGPathFill);
        
        //draw point
        CGContextSetAlpha(context, 1.0);
        CGFloat end = self.radius + 20;
        CGFloat start = self.radius - 20;
        CGFloat radian = (lastValue + part/2) * M_PI/180;
        CGFloat endPointX = self.center.x + end * cos(radian);
        CGFloat endPointY = self.center.y - end * sin(radian);
        CGFloat startPointX = self.center.x + start * cos(radian);
        CGFloat startPointY = self.center.y - start * sin(radian);
        CGPoint points[2];
        points[0] = CGPointMake(startPointX, startPointY);
        points[1] = CGPointMake(endPointX, endPointY);
        CGContextAddLines(context, points, 2);
        CGContextDrawPath(context, kCGPathStroke);
    
        //draw text
        CGContextSelectFont(context, "Arial", 15, kCGEncodingMacRoman);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSetTextMatrix(context, xform);
        if (endPointX <= self.center.x) {
            CGContextSetTextPosition(context, endPointX - 20, endPointY-5);
        }else{
            CGContextSetTextPosition(context, endPointX+5, endPointY);
        }
        CGContextShowText(context, [title UTF8String], strlen([title UTF8String]));
        
        
        lastValue += part;
    }
    //draw white hollowArch
    CGContextMoveToPoint(context, self.center.x, self.center.y);
    CGContextAddArc(context, self.center.x, self.center.y, self.radius/2, 0 * M_PI/180 , -180 * M_PI/180, 1);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
}


@end
