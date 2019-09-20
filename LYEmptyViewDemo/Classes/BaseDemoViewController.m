//
//  BaseDemoViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/7/28.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "BaseDemoViewController.h"

@interface BaseDemoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@end

@implementation BaseDemoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = MainColor(240, 240, 240);
    self.navigationController.navigationBar.tintColor = MainColor(70, 70, 70);
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:MainColor(70, 70, 70)}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColor(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [NSMutableArray array];
    
    [self setupUI];
}

- (void)setupUI{
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                            titleStr:@"暂无数据"
                                                           detailStr:nil];
    self.tableView.backgroundColor = MainColor(247, 247, 247);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)requestDataWithFinish:(LYRequestFinish)finish{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        
        [self.dataArray removeAllObjects];
        
        NSArray *arr = @[@"数据-0", @"数据-1", @"数据-2"];
        self.indexNumber = arr.count;
        [self.dataArray addObjectsFromArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (finish) {
                finish();
            }
        });
    });
}

- (IBAction)loadData:(id)sender {
    [self loadDataWithFinish:nil];
}
- (IBAction)clearData:(id)sender {
    [self clearData];
}

- (void)loadDataWithFinish:(LYRequestFinish)finish{
    if (!self.dataArray.count) {
        [self requestDataWithFinish:finish];
    } else {
        [self.dataArray addObject:[NSString stringWithFormat:@"数据-%zd", self.indexNumber++]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)clearData{
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        self.indexNumber = 0;
    }
}

- (void)changeClearBtnTitle:(NSString *)title{
    [self.clearBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - -------------- TableView DataSource -----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kStatusBarHeight + 44 + 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iden = @"cellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
