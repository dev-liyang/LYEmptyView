//
//  BaseDemoViewController.h
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/7/28.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYRequestFinish)(void);

@interface BaseDemoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger indexNumber;

- (void)loadDataWithFinish:(__nullable LYRequestFinish)finish;
- (void)clearData;
- (void)changeClearBtnTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
