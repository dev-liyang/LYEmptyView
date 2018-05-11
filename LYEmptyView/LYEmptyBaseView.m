//
//  LYEmptyBaseView.h
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/5/5.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYEmptyBaseView.h"

@interface LYEmptyBaseView ()

@end

@implementation LYEmptyBaseView

#pragma mark - ------------------ Life Cycle ------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.autoShowEmptyView = YES;//默认自动显隐
        
        [self prepare];
    }
    return self;
}
- (void)prepare{
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *view = self.superview;
    //不是UIScrollView，不做操作
    if (view && [view isKindOfClass:[UIView class]]){
        self.ly_width = view.ly_width;
        self.ly_height = view.ly_height;
    }
    
    [self setupSubviews];
}

- (void)setupSubviews{
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //不是UIScrollView，不做操作
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]]) return;
    
    if (newSuperview) {
        self.ly_width = newSuperview.ly_width;
        self.ly_height = newSuperview.ly_height;
    }
}

#pragma mark - ------------------ 实例化 ------------------
+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action{
    
    LYEmptyBaseView *emptyView = [[self alloc] init];
    
    [emptyView creatEmptyViewWithImageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr target:target action:action];
    
    return emptyView;
}
+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr btnClickBlock:(LYActionTapBlock)btnClickBlock{
    
    LYEmptyBaseView *emptyView = [[self alloc] init];
    
    [emptyView creatEmptyViewWithImageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr btnClickBlock:btnClickBlock];
    
    return emptyView;
}
+ (instancetype)emptyViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr{
    
    LYEmptyBaseView *emptyView = [[self alloc] init];
    
    [emptyView creatEmptyViewWithImageStr:imageStr titleStr:titleStr detailStr:detailStr btnTitleStr:nil btnClickBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyViewWithCustomView:(UIView *)customView{
    
    LYEmptyBaseView *emptyView = [[self alloc] init];
    
    [emptyView creatEmptyViewWithCustomView:customView];
    
    return emptyView;
}

- (void)creatEmptyViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action{
    
    _imageStr = imageStr;
    _titleStr = titleStr;
    _detailStr = detailStr;
    _btnTitleStr = btnTitleStr;
    _actionBtnTarget = target;
    _actionBtnAction = action;
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView:)];
        [_contentView addGestureRecognizer:tap];
    }
}

- (void)creatEmptyViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr btnClickBlock:(LYActionTapBlock)btnClickBlock{
    
    _imageStr = imageStr;
    _titleStr = titleStr;
    _detailStr = detailStr;
    _btnTitleStr = btnTitleStr;
    _btnClickBlock = btnClickBlock;
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView:)];
        [_contentView addGestureRecognizer:tap];
    }
}
- (void)creatEmptyViewWithCustomView:(UIView *)customView{
    
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    if (!_customView) {
        [_contentView addSubview:customView];
    }
    _customView = customView;
}

#pragma mark - ------------------ Setter ------------------

-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self layoutSubviews];
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self layoutSubviews];
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    [self layoutSubviews];
}
- (void)setBtnTitleStr:(NSString *)btnTitleStr{
    _btnTitleStr = btnTitleStr;
    [self layoutSubviews];
}
- (void)tapContentView:(UITapGestureRecognizer *)tap{
    if (_tapContentViewBlock) {
        _tapContentViewBlock();
    }
}

@end
