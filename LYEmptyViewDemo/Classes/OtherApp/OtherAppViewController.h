//
//  TestViewController.h
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/26.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ApplicationExsampleTypeQQ,
    ApplicationExsampleTypeWeiBo,
    ApplicationExsampleTypeYY,
    ApplicationExsampleTypePhotos,
    ApplicationExsampleTypeMeiTuan,
    ApplicationExsampleTypeJingDong
} ApplicationExsampleType;

@interface OtherAppViewController : UIViewController

@property (nonatomic, copy) NSString *vcTitle;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *viewBackgroundColor;
@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, assign) ApplicationExsampleType appType;

@end
