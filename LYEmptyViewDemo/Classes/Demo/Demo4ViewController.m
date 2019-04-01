//
//  Demo4ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/12/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo4ViewController.h"
#import "DemoEmptyView.h"

@interface Demo4ViewController ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation Demo4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"数据-0", @"数据-1"]];
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:@[]];
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:arr];
    [self.dataArray addObject:arr1];
    
    [self setUI];
    
    [self setEmpty];
}

- (void)setUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    DemoEmptyView *emptyView = [DemoEmptyView diyEmptyView];
    //emptyView.autoShowEmptyView = NO; //二次封装的DemoEmptyView内如果设置过了，此处也可不写
    emptyView.contentViewOffset = 50;//偏移
    emptyView.imageSize = CGSizeMake(70, 70);//设置图片大小
    self.tableView.ly_emptyView = emptyView;
}

//模拟网络请求
- (void)requestDataWithFinish:(LYRequestFinish)finish{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (![self.dataArray[1] count]) {
            sleep(1);
            [self.dataArray[1] removeAllObjects];
            NSMutableArray *arr = [@[@"数据-1-0", @"数据-1-1", @"数据-1-2"] mutableCopy];
            [self.dataArray[1] addObjectsFromArray:arr];
            self.indexNumber = 3;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {
                    finish();
                }
            });
        } else {
            [self.dataArray[1] addObject:[NSString stringWithFormat:@"数据-1-%zd", self.indexNumber++]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {
                    finish();
                }
            });
        }
    });
}

- (void)loadDataWithFinish:(LYRequestFinish)finish{
    
    [self.tableView ly_hideEmptyView]; //手动隐藏emptyView
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //发起网络请求
    [self requestDataWithFinish:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
        [self setEmpty];//手动去判断emptyView的显隐
    }];
}

- (void)clearData{
    [self.dataArray[1] removeAllObjects];
    [self.tableView reloadData];
    [self setEmpty];//手动去判断emptyView的显隐
}

- (void)setEmpty{
    //需要自己去判断有无数据，从而根据有无情况进行显示
    if (self.dataArray.count >= 2) {
        if ([self.dataArray[1] count]) {
            [self.tableView ly_hideEmptyView];//手动隐藏emptyView
        }else{
            [self.tableView ly_showEmptyView];//手动显示emptyView
        }
    }else{
        [self.tableView ly_showEmptyView];//手动显示emptyView
    }
}

#pragma mark - -------------- TableView DataSource -----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iden = @"cellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    label.text = [NSString stringWithFormat:@"组头-%ld", section];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    return label;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
