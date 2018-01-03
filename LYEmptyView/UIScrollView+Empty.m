//
//  UIScrollView+Empty.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/26.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import <objc/runtime.h>
#import "LYEmptyView.h"

@implementation UIScrollView (Empty)

#pragma mark - Setter/Getter

static char kEmptyViewKey;
- (void)setLy_emptyView:(LYEmptyView *)ly_emptyView{
    if (ly_emptyView != self.ly_emptyView) {
        
        objc_setAssociatedObject(self, &kEmptyViewKey, ly_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[LYEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.ly_emptyView];
    }
}
- (LYEmptyView *)ly_emptyView{
    return  objc_getAssociatedObject(self, &kEmptyViewKey);
}

#pragma mark - Private Method
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}

- (void)show{
    
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 ly_showEmptyView
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.ly_emptyView.hidden = YES;
        return;
    }

    [self ly_showEmptyView];
}
- (void)hide{
    
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.ly_emptyView.hidden = YES;
        return;
    }

    [self ly_hideEmptyView];
}

#pragma mark - Public Method
- (void)ly_showEmptyView{
    
    [self.ly_emptyView.superview layoutSubviews];
    
    self.ly_emptyView.hidden = NO;
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.ly_emptyView];
}
- (void)ly_hideEmptyView{
    self.ly_emptyView.hidden = YES;
}

- (void)ly_startLoading{
    self.ly_emptyView.hidden = YES;
}
- (void)ly_endLoading{
    if ([self totalDataCount] == 0) {
        self.ly_emptyView.hidden = NO;
    }else{
        self.ly_emptyView.hidden = YES;
    }
}

@end

@implementation UITableView (Empty)
+ (void)load{
    
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ly_reloadData = class_getInstanceMethod(self, @selector(ly_reloadData));
    method_exchangeImplementations(reloadData, ly_reloadData);
    
    ///section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:withRowAnimation:));
    Method ly_insertSections = class_getInstanceMethod(self, @selector(ly_insertSections:withRowAnimation:));
    method_exchangeImplementations(insertSections, ly_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:withRowAnimation:));
    Method ly_deleteSections = class_getInstanceMethod(self, @selector(ly_deleteSections:withRowAnimation:));
    method_exchangeImplementations(deleteSections, ly_deleteSections);
    
    ///row
    Method insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:));
    Method ly_insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ly_insertRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(insertRowsAtIndexPaths, ly_insertRowsAtIndexPaths);
    
    Method deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteRowsAtIndexPaths:withRowAnimation:));
    Method ly_deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ly_deleteRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(deleteRowsAtIndexPaths, ly_deleteRowsAtIndexPaths);
    
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)ly_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

@implementation UICollectionView (Empty)
+ (void)load{
    
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ly_reloadData = class_getInstanceMethod(self, @selector(ly_reloadData));
    method_exchangeImplementations(reloadData, ly_reloadData);
    
    ///section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:));
    Method ly_insertSections = class_getInstanceMethod(self, @selector(ly_insertSections:));
    method_exchangeImplementations(insertSections, ly_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:));
    Method ly_deleteSections = class_getInstanceMethod(self, @selector(ly_deleteSections:));
    method_exchangeImplementations(deleteSections, ly_deleteSections);
    
    ///item
    Method insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(insertItemsAtIndexPaths:));
    Method ly_insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ly_insertItemsAtIndexPaths:));
    method_exchangeImplementations(insertItemsAtIndexPaths, ly_insertItemsAtIndexPaths);
    
    Method deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteItemsAtIndexPaths:));
    Method ly_deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ly_deleteItemsAtIndexPaths:));
    method_exchangeImplementations(deleteItemsAtIndexPaths, ly_deleteItemsAtIndexPaths);
    
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections{
    [self ly_insertSections:sections];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections{
    [self ly_deleteSections:sections];
    [self getDataAndSet];
}
///item
- (void)ly_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)ly_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
@end


