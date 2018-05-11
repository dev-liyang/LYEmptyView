//
//  Demo2ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/7/28.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo2ViewController.h"
#import "DemoEmptyView.h"


@interface Demo2ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;


@end

@implementation Demo2ViewController

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
    
    [self requestData];
}

- (void)setupUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainColor(240, 240, 240);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    ///设置emptyView
    DemoEmptyView *empty = [DemoEmptyView diyEmptyActionViewWithTarget:self action:@selector(getData:)];
//    empty.autoShowEmptyView = NO;//框架默认自动显隐，初始化tableView没有数据时会显示emptyView，故此处应关闭自动显隐，如进行了二次封装，此处也可不写
    self.tableView.ly_emptyView = empty;

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

- (void)getData:(id)sender{
    [self requestData];
}

- (void)requestData{
    
    //网络请求时调用
    [self.tableView ly_startLoading];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        _index ++;
        [self.dataArray removeAllObjects];
        
        NSArray *arr;
        if (_index%2==0) {
            arr = @[@"数据1", @"数据2", @"数据3", @"数据4", @"数据5"];
        }
        [self.dataArray addObjectsFromArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            //调用时机
            [self.tableView ly_endLoading];
        });
    });
}
- (IBAction)loadData:(id)sender {
    [self requestData];
}
- (IBAction)clearData:(id)sender {
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    //在reloadData 后调用
    [self.tableView ly_endLoading];
}

@end

