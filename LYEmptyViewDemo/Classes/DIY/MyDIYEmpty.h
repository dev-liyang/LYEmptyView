//
//  MyDIYEmpty.h
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/27.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYEmptyView.h"

@interface MyDIYEmpty : LYEmptyView

+ (instancetype)diyEmptyView;

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action;

@end
