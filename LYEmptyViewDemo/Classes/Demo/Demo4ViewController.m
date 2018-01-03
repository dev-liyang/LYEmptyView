//
//  Demo4ViewController.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/12/1.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "Demo4ViewController.h"
#import "DemoEmptyView.h"

@interface Demo4ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation Demo4ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = MainColor(240, 240, 240);
    self.navigationController.navigationBar.tintColor = MainColor(70, 70, 70);

    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:MainColor(70, 70, 70)}];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColor(247, 247, 247);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"数据-0", @"数据-0"]];
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:@[]];
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:arr];
    [self.dataArray addObject:arr1];
    
    [self setupUI];
    
    [self setEmpty];
}

- (void)setupUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainColor(240, 240, 240);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    DemoEmptyView *emptyView = [DemoEmptyView diyEmptyView];
    NSLog(@"DemoEmptyView:%@",emptyView);
    self.tableView.ly_emptyView = emptyView;
    self.tableView.ly_emptyView.imageSize = CGSizeMake(80, 80);
    self.tableView.ly_emptyView.contentViewOffset = 50;
//    self.tableView.ly_emptyView.contentViewY = kStatusBarHeight + 44 + 114 + 50;
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
    if (section == 0) {
        return kStatusBarHeight + 44 + 10;
    }
    return 10;
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
    
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
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
    
    [self.tableView ly_hideEmptyView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        [self.dataArray[1] removeAllObjects];
        NSArray *arr = @[@"数据-1", @"数据-1"];
        [self.dataArray[1] addObjectsFromArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            [self setEmpty];
        });
    });
}

- (IBAction)loadData:(id)sender {
    [self requestData];
}
- (IBAction)clearData:(id)sender {
    [self.dataArray[1] removeAllObjects];
    [self.tableView reloadData];
    [self setEmpty];
}

- (void)setEmpty{
    if (self.dataArray.count >= 2) {
        if ([self.dataArray[1] count]) {
            [self.tableView ly_hideEmptyView];
        }else{
            [self.tableView ly_showEmptyView];
        }
    }else{
        [self.tableView ly_showEmptyView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
