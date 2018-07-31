//
//  Demo6ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2018/7/31.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "Demo6ViewController.h"
#import "DemoEmptyView.h"

@interface Demo6ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation Demo6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = MainColor(247, 247, 247);
    self.navigationController.navigationBar.tintColor = MainColor(70, 70, 70);
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:MainColor(70, 70, 70)}];
    
    self.dataArray = [NSMutableArray array];
    
    [self setupUI];
    
    [self setupEmptyView];
    
    [self requestData];
}

- (void)setupUI{
    CGFloat tabbarH = self.tabBarController.tabBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, kStatusBarHeight + 44, kMainScreenWidth, kMainScreenHeight - kStatusBarHeight - 44 - tabbarH);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainColor(252, 252, 252);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kMainScreenWidth, 40)];
    [tableHeader addSubview:label];
    label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    label.text = @"tableHeaderView-头视图";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    self.tableView.tableHeaderView = tableHeader;
    
}

- (void)setupEmptyView{
    
    DemoEmptyView *emptyView = [DemoEmptyView diyEmptyView];
    emptyView.emptyViewIsCompleteCoverSuperView = YES;//完全覆盖父视图，背景色默认为浅白色，可自行设置
//    emptyView.backgroundColor = [UIColor redColor];//自己设置背景色为红色，此设置也可封装到公共的地方（DemoEmptyView），就不用每次设置了
    self.tableView.ly_emptyView = emptyView;
}

#pragma mark - -------------- TableView DataSource -----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
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
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)requestData{
    
    //网络请求时调用
    [self.tableView ly_startLoading];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        [self.dataArray removeAllObjects];
        NSArray *arr = @[@"数据1", @"数据2", @"数据3", @"数据4", @"数据5"];
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
