//
//  Demo1ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/7/28.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    
    //1 使用框架UI样式，直接调用
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                            titleStr:@"暂无数据"
                                                           detailStr:@""];
    
    //2 使用自定义UI样式，MyDIYEmpty 是继承自LYEmptyView 的自定义的 empty
    //2-1
//    self.tableView.ly_emptyView = [MyDIYEmpty emptyViewWithImageStr:@"noData"
//                                                           titleStr:@"暂无数据"
//                                                          detailStr:@"请检查您的网络连接是否正确!"];
    
    //2-2 和2-1方式一样效果,只是多封装了一下
//    self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
}



@end
