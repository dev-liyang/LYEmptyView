//
//  Demo2ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/7/28.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo2ViewController.h"

@interface Demo2ViewController ()

@end

@implementation Demo2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self loadDataWithFinish:nil];
}

- (void)setUI{
    
    //方式1
//        LYEmptyView *empty = [LYEmptyView emptyViewWithImageStr:@"noData"
//                                                       titleStr:@"暂无数据"
//                                                      detailStr:@""];
    //    empty.autoShowEmptyView = NO;//框架默认自动显隐，初始化tableView没有数据时会显示emptyView，故此处应关闭自动显隐
    //    self.tableView.ly_emptyView = empty;
    
    //方式2
    DemoEmptyView *empty = [DemoEmptyView diyEmptyView];
    //empty.autoShowEmptyView = NO; //二次封装的DemoEmptyView内如果设置过了，此处也可不写
    self.tableView.ly_emptyView = empty;
}

- (void)loadDataWithFinish:(LYRequestFinish)finish{
    
    //网络请求时调用
    [self.tableView ly_startLoading];
    
    //这里面是网络请求
    [super loadDataWithFinish:^{
        
        //回调到这里，网络请求结束，tableview已经reloadData
        
        [self.tableView ly_endLoading];//必须保证在reloadData后调用
    }];
}

- (void)clearData{
    
    [super clearData]; //tableview已经reloadData
    
    [self.tableView ly_endLoading];//必须保证在reloadData后调用
}

@end
