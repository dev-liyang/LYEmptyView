//
//  Demo3ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/12/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo3ViewController.h"

@interface Demo3ViewController ()

@property (nonatomic, strong) DemoEmptyView *noDataView;
@property (nonatomic, strong) DemoEmptyView *noNetworkView;

@end

@implementation Demo3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self loadData];
}

- (void)setUI{
    self.tableView.ly_emptyView = self.noDataView;
    [self changeClearBtnTitle:@"切换样式"];
}

- (void)clearData{
    
    [super clearData];
    
    //切换样式
    if (self.tableView.ly_emptyView == self.noDataView) {
        self.tableView.ly_emptyView = self.noNetworkView;
    } else {
        self.tableView.ly_emptyView = self.noDataView;
    }
    
    [self.tableView ly_endLoading];
}

- (void)loadData{
    [self.tableView ly_startLoading];
    [self loadDataWithFinish:^{
        [self.tableView ly_endLoading];
    }];
}

- (DemoEmptyView *)noDataView{
    if (!_noDataView) {
        _noDataView = [DemoEmptyView diyEmptyView];
        //_noDataView.autoShowEmptyView = NO; //二次封装的DemoEmptyView内如果设置过了，此处也可不写
    }
    return _noDataView;
}

- (DemoEmptyView *)noNetworkView{
    if (!_noNetworkView) {
        _noNetworkView = [DemoEmptyView diyEmptyActionViewWithTarget:self action:@selector(loadData)];
        //_noNetworkView.autoShowEmptyView = NO; //二次封装的DemoEmptyView内如果设置过了，此处也可不写
    }
    return _noNetworkView;
}

@end
