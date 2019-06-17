//
//  Demo6ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2018/7/31.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "Demo6ViewController.h"
#import "DemoEmptyView.h"

@interface Demo6ViewController ()
@property (nonatomic, strong) UIView *tableHeaderView;
@end

@implementation Demo6ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, 88);
}

- (void)setUI{
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    DemoEmptyView *emptyView = [DemoEmptyView diyEmptyView];
    emptyView.emptyViewIsCompleteCoverSuperView = YES;//完全覆盖父视图，背景色默认为浅白色，可自行设置
//    emptyView.backgroundColor = [UIColor redColor];//自己设置背景色为红色，此设置也可封装到公共的地方（DemoEmptyView），就不用每次设置了
    self.tableView.ly_emptyView = emptyView;
    
    [emptyView setTapEmptyViewBlock:^{
        NSLog(@"点击了屏幕...");
    }];
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

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 0, 44)];
        [_tableHeaderView addSubview:label];
        _tableHeaderView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        label.text = @"tableHeaderView-头视图";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        [label sizeToFit];
    }
    return _tableHeaderView;
}

@end
