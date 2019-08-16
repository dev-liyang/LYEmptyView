//
//  TestViewController.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/26.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "OtherAppViewController.h"

@interface OtherAppViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation OtherAppViewController
{
    NSInteger IndexNumber;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = self.barTintColor;
    self.navigationController.navigationBar.tintColor = self.tintColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:self.tintColor}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.vcTitle;
    self.view.backgroundColor = self.viewBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [NSMutableArray array];
    
    [self setupUI];
    
}

- (void)setupUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.viewBackgroundColor;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self setApp:self.appType];
    
}

- (void)setApp:(ApplicationExsampleType)apptype{
    
    
    __weak typeof(self)weakSelf = self;
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:_dataDic[@"image"]
                                                             titleStr:_dataDic[@"titleStr"]
                                                            detailStr:_dataDic[@"detailStr"]
                                                          btnTitleStr:_dataDic[@"btnTitle"]
                                                        btnClickBlock:^(){
        [weakSelf addDataClick:nil];
    }];
    
    switch (apptype) {
        case ApplicationExsampleTypeQQ:{
            emptyView.subViewMargin = 14.f;
            emptyView.titleLabFont = [UIFont systemFontOfSize:15.f];
            emptyView.titleLabTextColor = MainColor(172, 172, 172);
        }
            break;
        case ApplicationExsampleTypeWeiBo:{
            emptyView.subViewMargin = 28.f;
            emptyView.contentViewOffset = - 50;
            
            emptyView.titleLabFont = [UIFont systemFontOfSize:14.f];
            emptyView.titleLabTextColor = MainColor(199, 199, 199);
            
            emptyView.actionBtnFont = [UIFont boldSystemFontOfSize:16.f];
            emptyView.actionBtnTitleColor = MainColor(70, 70, 70);
            emptyView.actionBtnHeight = 40.f;
            emptyView.actionBtnHorizontalMargin = 62.f;
            emptyView.actionBtnCornerRadius = 2.f;
            emptyView.actionBtnBorderColor = MainColor(204, 204, 204);
            emptyView.actionBtnBorderWidth = 0.5;
            emptyView.actionBtnBackGroundColor = self.viewBackgroundColor;
        }
            break;
        case ApplicationExsampleTypeYY:{
            emptyView.subViewMargin = 36.f;
            
            emptyView.titleLabFont = [UIFont systemFontOfSize:15.f];
            emptyView.titleLabTextColor = MainColor(78, 78, 78);
            
            emptyView.actionBtnFont = [UIFont systemFontOfSize:15.f];
            emptyView.actionBtnTitleColor = MainColor(51, 51, 51);
            emptyView.actionBtnHeight = 40.f;
            emptyView.actionBtnHorizontalMargin = 74.f;
            emptyView.actionBtnCornerRadius = 20.f;
            emptyView.actionBtnBackGroundColor = MainColor(254, 219, 49);
            emptyView.actionBtnBackGroundGradientColors = @[[UIColor redColor], [UIColor orangeColor]];
            emptyView.actionBtnMargin = 100.0f;
        }
            break;
            
        case ApplicationExsampleTypePhotos:{
            emptyView.titleLabFont = [UIFont systemFontOfSize:25.f];
            emptyView.titleLabTextColor = MainColor(146, 146, 146);
            
            emptyView.detailLabFont = [UIFont systemFontOfSize:17.f];
            emptyView.detailLabTextColor = MainColor(153, 153, 153);
        }
            break;
            
        case ApplicationExsampleTypeMeiTuan:{
            emptyView.subViewMargin = 38.f;
            emptyView.contentViewY = 100;
            
            emptyView.titleLabFont = [UIFont systemFontOfSize:12.f];
            emptyView.titleLabTextColor = MainColor(170, 170, 170);
            
            emptyView.actionBtnFont = [UIFont systemFontOfSize:12.f];
            emptyView.actionBtnBorderWidth = 0;
            emptyView.actionBtnBackGroundColor = [UIColor clearColor];
            emptyView.actionBtnHeight = 12.f;
            emptyView.actionBtnTitleColor = MainColor(0, 189, 170);
        }
            break;
            
        case ApplicationExsampleTypeJingDong:{
            emptyView.subViewMargin = 12.f;
            
            emptyView.titleLabTextColor = MainColor(125, 125, 125);
            
            emptyView.detailLabTextColor = MainColor(192, 192, 192);
            
            emptyView.actionBtnFont = [UIFont systemFontOfSize:15.f];
            emptyView.actionBtnTitleColor = MainColor(90, 90, 90);
            emptyView.actionBtnHeight = 30.f;
            emptyView.actionBtnHorizontalMargin = 22.f;
            emptyView.actionBtnCornerRadius = 2.f;
            emptyView.actionBtnBorderColor = MainColor(150, 150, 150);
            emptyView.actionBtnBorderWidth = 0.5;
            emptyView.actionBtnBackGroundColor = self.viewBackgroundColor;
        }
            break;
        default:
            break;
    }
    self.tableView.ly_emptyView = emptyView;
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
    // 隐藏对应子视图，只需要清空里面的内容即可
//    self.tableView.ly_emptyView.image = nil;
//    self.tableView.ly_emptyView.imageStr = nil;
//    self.tableView.ly_emptyView.titleStr = nil;
//    self.tableView.ly_emptyView.btnMargin = 0.0f;
    
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
