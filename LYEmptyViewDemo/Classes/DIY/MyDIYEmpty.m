//
//  MyDIYEmpty.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/27.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "MyDIYEmpty.h"

@implementation MyDIYEmpty

+ (instancetype)diyEmptyView{
    return [MyDIYEmpty emptyViewWithImageStr:@"nodata" titleStr:@"暂无数据" detailStr:@"请检查您的网络连接是否正确!"];
}
+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action{
    
    MyDIYEmpty *diy = [MyDIYEmpty emptyActionViewWithImageStr:@"noData" titleStr:@"暂无数据" detailStr:@"请检查你的网络连接是否正确!" btnTitleStr:@"重新加载" target:target action:action];
    diy.autoShowEmptyView = NO;
    
    diy.imageSize = CGSizeMake(150, 150);
    
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
