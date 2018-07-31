//
//  Demo5ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2018/5/10.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "Demo5ViewController.h"
#import "DemoEmptyView.h"

@interface Demo5ViewController ()

@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColor(247, 247, 247);
    
    self.view.ly_emptyView = [DemoEmptyView emptyViewWithImageStr:@"noData" titleStr:@"啥都没有" detailStr:@"直接为VC的View添加占位图"];
    
    //显示占位图
    [self.view ly_showEmptyView];

    //隐藏占位图
//    [self.view ly_hideEmptyView];
}

@end
