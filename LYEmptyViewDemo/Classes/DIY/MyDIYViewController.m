//
//  MyDIYViewController.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/27.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "MyDIYViewController.h"

@interface MyDIYViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyDIYViewController
{
    NSInteger IndexNumber;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = MainColor(247, 247, 247);
    self.navigationController.navigationBar.tintColor = MainColor(70, 70, 70);
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:MainColor(70, 70, 70)}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.dataDic[@"title"];
    self.view.backgroundColor = MainColor(247, 247, 247);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [NSMutableArray array];
    
    [self setupUI];
        
}

- (void)setupUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainColor(247, 247, 247);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (![self.dataDic[@"title"] isEqualToString:@"DIY6"]) {
        
        self.tableView.ly_emptyView = [MyDIYEmpty emptyActionViewWithImageStr:_dataDic[@"image"]
                                                                     titleStr:_dataDic[@"titleStr"]
                                                                    detailStr:_dataDic[@"detailStr"]
                                                                  btnTitleStr:_dataDic[@"btnTitle"]
                                                                       target:self
                                                                       action:@selector(addDataClick:)];
        
    }else{//自定义view

//        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
//
//        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
//        titleLab.font = [UIFont systemFontOfSize:16];
//        titleLab.textAlignment = NSTextAlignmentCenter;
//        titleLab.text = @"暂无数据，请稍后再试！";
//        [customView addSubview:titleLab];
//
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
//        button.backgroundColor = [UIColor blueColor];
//        [button setTitle:@"重试" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15];
//        [button addTarget:self action:@selector(addDataClick:) forControlEvents:UIControlEventTouchUpInside];
//        [customView addSubview:button];
//
//        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
//        button2.backgroundColor = [UIColor redColor];
//        [button2 setTitle:@"加载" forState:UIControlStateNormal];
//        button2.titleLabel.font = [UIFont systemFontOfSize:15];
//        [button2 addTarget:self action:@selector(addDataClick:) forControlEvents:UIControlEventTouchUpInside];
//         [customView addSubview:button2];

//        self.tableView.ly_emptyView = [LYEmptyView emptyViewWithCustomView:customView];
        
        //二次封装
        self.tableView.ly_emptyView = [MyDIYEmpty diyCustomEmptyViewWithTarget:self action:@selector(addDataClick:)];
    }
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

- (IBAction)addDataClick:(id)sender {
    IndexNumber ++;
    NSString *str = [NSString stringWithFormat:@"数字%ld", IndexNumber];
    
    if (IndexNumber > 0) {
        
        [self.dataArray addObject:str];
        [self.tableView reloadData];
    }
}
- (IBAction)deleteDataClick:(id)sender {
    if (IndexNumber <= 0) {
        return;
    }
    IndexNumber --;
    [self.dataArray removeLastObject];
    [self.tableView reloadData];
}

@end

