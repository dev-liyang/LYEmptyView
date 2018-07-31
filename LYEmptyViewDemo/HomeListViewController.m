//
//  HomeListViewController.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/27.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "HomeListViewController.h"
#import "OtherAppViewController.h"
#import "MyDIYViewController.h"

@interface HomeListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    [self loadData];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] init];
    barItem.title = @"";
    self.navigationItem.backBarButtonItem = barItem;
}

- (void)setupUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)loadData{
    
    NSArray *array = @[@{@"name" : @"Demo1ViewController",
                          @"title" : @"Demo1 一行代码集成占位图"},
                        @{@"name" : @"Demo2ViewController",
                          @"title" : @"Demo2 延迟显示占位图"},
                        @{@"name" : @"Demo3ViewController",
                          @"title" : @"Demo3 随意切换占位图样式"},
                       @{@"name" : @"Demo4ViewController",
                         @"title" : @"Demo4 手动控制占位图显示隐藏"},
                       @{@"name" : @"Demo5ViewController",
                         @"title" : @"Demo5 其他View集成占位图方式"},
                       @{@"name" : @"Demo6ViewController",
                         @"title" : @"Demo6 占位图完全覆盖父视图"}];
    
    NSArray *array2 = @[@{@"icon" : @"qq",
                         @"title" : @"QQ"},
                        @{@"icon" : @"weibo",
                         @"title" : @"Weibo"},
                        @{@"icon" : @"yy",
                         @"title" : @"YY"},
                        @{@"icon" : @"photos",
                         @"title" : @"Photos"},
                        @{@"icon" : @"meituan",
                         @"title" : @"MeiTuan"},
                        @{@"icon" : @"jingdong",
                         @"title" : @"JingDong"}];
    
    NSArray *array3 = @[@{@"icon" : @"diy",
                         @"title" : @"DIY1"},
                       @{@"icon" : @"diy",
                         @"title" : @"DIY2"},
                       @{@"icon" : @"diy",
                         @"title" : @"DIY3"},
                        @{@"icon" : @"diy",
                          @"title" : @"DIY4"},
                        @{@"icon" : @"diy",
                          @"title" : @"DIY5"},
                        @{@"icon" : @"diy",
                          @"title" : @"DIY6"}];
    
    self.dataArray = [NSMutableArray arrayWithArray:@[array, array2, array3]];
    
    [self.tableView reloadData];
}

#pragma mark - -------------- TableView DataSource -----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
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
    
    NSDictionary *dic = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self getoDemo:indexPath];
        
    }else if(indexPath.section == 1){
        [self gotoOtherAPP:indexPath];
        
    }else{
        [self gotoDIY:indexPath];
    }
}

- (void)getoDemo:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.section][indexPath.row];
    NSString *vcClassName = [dic objectForKey:@"name"];
    NSString *title = [dic objectForKey:@"title"];
    
    Class class = NSClassFromString(vcClassName);
    
    UIViewController *vc = [[class alloc] init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoOtherAPP:(NSIndexPath *)indexPath{
    
    OtherAppViewController *test = [[OtherAppViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            test.vcTitle = @"QQ";
            test.barTintColor = MainColor(65, 175, 250);
            test.tintColor = MainColor(255, 255, 255);
            test.viewBackgroundColor = MainColor(247, 247, 247);
            test.appType = ApplicationExsampleTypeQQ;
            test.dataDic = @{@"image" : @"empty_qq",
                             @"titleStr" : @"暂时没有新消息",
                             @"detailStr" : @"",
                             @"btnTitle" : @""};
        }
            break;
        case 1:
        {
            test.vcTitle = @"WeiBo";
            test.barTintColor = MainColor(246, 246, 246);
            test.tintColor = MainColor(70, 70, 70);
            test.viewBackgroundColor = MainColor(242, 242, 242);
            test.appType = ApplicationExsampleTypeWeiBo;
            test.dataDic = @{@"image" : @"empty_weibo",
                             @"titleStr" : @"网络出错了，请点击按钮重新加载",
                             @"detailStr" : @"",
                             @"btnTitle" : @"重新加载"};
            
        }
            break;
        case 2:
        {
            test.vcTitle = @"YY";
            test.barTintColor = MainColor(255, 255, 255);
            test.tintColor = MainColor(254, 219, 49);
            test.viewBackgroundColor = MainColor(245, 245, 245);
            test.appType = ApplicationExsampleTypeYY;
            test.dataDic = @{@"image" : @"empty_yy",
                             @"titleStr" : @"您附近没有主播在开播喔",
                             @"detailStr" : @"",
                             @"btnTitle" : @"刷新试试"};
            
        }
            break;
        case 3:
        {
            test.vcTitle = @"Photos";
            test.barTintColor = MainColor(249, 249, 249);
            test.tintColor = MainColor(22, 126, 251);
            test.viewBackgroundColor = MainColor(255, 255, 255);
            test.appType = ApplicationExsampleTypePhotos;
            test.dataDic = @{@"image" : @"empty_photos",
                             @"titleStr" : @"无照片或视频",
                             @"detailStr" : @"您可以使用相机拍摄照片和视频，或使用iTunes加个照片和视频同步到iPhone。",
                             @"btnTitle" : @""};
            
        }
            break;
        case 4:
        {
            test.vcTitle = @"MeiTuan";
            test.barTintColor = MainColor(250, 250, 250);
            test.tintColor = MainColor(26, 192, 173);
            test.viewBackgroundColor = MainColor(244, 244, 244);
            test.appType = ApplicationExsampleTypeMeiTuan;
            test.dataDic = @{@"image" : @"empty_meituan",
                             @"titleStr" : @"您还没有抵用券",
                             @"detailStr" : @"",
                             @"btnTitle" : @"查看失效券"};
            
        }
            break;
        case 5:
        {
            test.vcTitle = @"京东";
            test.barTintColor = MainColor(244, 245, 247);
            test.tintColor = MainColor(233, 50, 38);
            test.viewBackgroundColor = MainColor(244, 245, 247);
            test.appType = ApplicationExsampleTypeJingDong;
            test.dataDic = @{@"image" : @"empty_jd",
                             @"titleStr" : @"网络请求失败",
                             @"detailStr" : @"请检查您的网络\n重新加载吧",
                             @"btnTitle" : @"重新加载"};
            
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:test animated:YES];
}
- (void)gotoDIY:(NSIndexPath *)indexPath{
    MyDIYViewController *diyVC = [[MyDIYViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            diyVC.dataDic = @{@"title" : @"DIY1",
                              @"image" : @"empty_qq",
                              @"titleStr" : @"无数据",
                              @"detailStr" : @"",
                              @"btnTitle" : @""};
            
        }
            break;
            
        case 1:
        {
            diyVC.dataDic = @{@"title" : @"DIY2",
                              @"image" : @"empty_qq",
                              @"titleStr" : @"",
                              @"detailStr" : @"",
                              @"btnTitle" : @"重新加载"};
            
        }
            break;
            
        case 2:
        {
            diyVC.dataDic = @{@"title" : @"DIY3",
                              @"image" : @"empty_qq",
                              @"titleStr" : @"无数据",
                              @"detailStr" : @"当前没有数据，请稍后再试吧！",
                              @"btnTitle" : @""};
            
        }
            break;
            
        case 3:
        {
            diyVC.dataDic = @{@"title" : @"DIY4",
                              @"image" : @"empty_qq",
                              @"titleStr" : @"无数据",
                              @"detailStr" : @"当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！当前没有数据，请稍后再试吧！",
                              @"btnTitle" : @""};
            
        }
            break;
            
        case 4:
        {
            diyVC.dataDic = @{@"title" : @"DIY5",
                              @"image" : @"empty_qq",
                              @"titleStr" : @"无数据",
                              @"detailStr" : @"当前没有数据，请稍后再试吧！",
                              @"btnTitle" : @"重新加载"};
            
        }
            break;
            
        case 5:
        {
            diyVC.dataDic = @{@"title" : @"DIY6"};
            
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:diyVC animated:YES];
}

@end

