//
//  UIView+LYExtension.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/12.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "UIView+LYExtension.h"

@implementation UIView (LYExtension)

- (void)setLy_x:(CGFloat)ly_x{
    
    CGRect frame = self.frame;
    frame.origin.x = ly_x;
    self.frame = frame;
}
- (CGFloat)ly_x
{
    return self.frame.origin.x;
}

- (void)setLy_y:(CGFloat)ly_y{
    
    CGRect frame = self.frame;
    frame.origin.y = ly_y;
    self.frame = frame;
}
- (CGFloat)ly_y
{
    return self.frame.origin.y;
}

- (void)setLy_centerX:(CGFloat)ly_centerX{
    CGPoint center = self.center;
    center.x = ly_centerX;
    self.center = center;
}
- (CGFloat)ly_centerX
{
    return self.center.x;
}

- (void)setLy_centerY:(CGFloat)ly_centerY
{
    CGPoint center = self.center;
    center.y = ly_centerY;
    self.center = center;
}
- (CGFloat)ly_centerY
{
    return self.center.y;
}

- (void)setLy_width:(CGFloat)ly_width
{
    CGRect frame = self.frame;
    frame.size.width = ly_width;
    self.frame = frame;
}
- (CGFloat)ly_width
{
    return self.frame.size.width;
}

- (void)setLy_height:(CGFloat)ly_height
{
    CGRect frame = self.frame;
    frame.size.height = ly_height;
    self.frame = frame;
}
- (CGFloat)ly_height
{
    return self.frame.size.height;
}

- (void)setLy_size:(CGSize)ly_size
{
    CGRect frame = self.frame;
    frame.size = ly_size;
    self.frame = frame;
}
- (CGSize)ly_size
{
    return self.frame.size;
}

- (void)setLy_origin:(CGPoint)ly_origin
{
    CGRect frame = self.frame;
    frame.origin = ly_origin;
    self.frame = frame;
}

- (CGPoint)ly_origin
{
    return self.frame.origin;
}
- (CGFloat)ly_maxX{
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)ly_maxY{
    return self.frame.origin.y + self.frame.size.height;
}

@end

