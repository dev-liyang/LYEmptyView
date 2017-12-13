//
//  UIView+LYExtension.h
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/12.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYExtension)

@property (nonatomic, assign) CGFloat ly_x;
@property (nonatomic, assign) CGFloat ly_y;
@property (nonatomic, assign) CGFloat ly_width;
@property (nonatomic, assign) CGFloat ly_height;
@property (nonatomic, assign) CGFloat ly_centerX;
@property (nonatomic, assign) CGFloat ly_centerY;
@property (nonatomic, assign) CGSize  ly_size;
@property (nonatomic, assign) CGPoint ly_origin;
@property (nonatomic, assign, readonly) CGFloat ly_maxX;
@property (nonatomic, assign, readonly) CGFloat ly_maxY;


@end

