//
//  MyDIYEmpty.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/27.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "MyDIYEmpty.h"

@implementation MyDIYEmpty

+ (instancetype)diyNoDataEmpty{
    return [MyDIYEmpty emptyViewWithImageStr:@"nodata"
                                    titleStr:@"暂无数据"
                                   detailStr:@"请检查您的网络连接是否正确!"];
}
+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action{
    
    MyDIYEmpty *diy = [MyDIYEmpty emptyActionViewWithImageStr:@"noData"
                                                     titleStr:@"暂无数据"
                                                    detailStr:@"请检查你的网络连接是否正确!"
                                                  btnTitleStr:@"重新加载"
                                                       target:target
                                                       action:action];
    diy.autoShowEmptyView = NO;
    
    diy.imageSize = CGSizeMake(150, 150);
    
    return diy;
}

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action{
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"暂无数据，请稍后再试！";
    [customView addSubview:titleLab];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"重试" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"加载" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button2];
    
    MyDIYEmpty *diy = [MyDIYEmpty emptyViewWithCustomView:customView];
    return diy;
}

- (void)prepare{
    [super prepare];
    
    self.subViewMargin = 20.f;
    
    self.titleLabFont = [UIFont systemFontOfSize:25];
    self.titleLabTextColor = MainColor(90, 180, 160);
    
    self.detailLabFont = [UIFont systemFontOfSize:17];
    self.detailLabTextColor = MainColor(180, 120, 90);
    self.detailLabMaxLines = 5;
    
    self.actionBtnBackGroundColor = MainColor(90, 180, 160);
    self.actionBtnTitleColor = [UIColor whiteColor];
}

@end
