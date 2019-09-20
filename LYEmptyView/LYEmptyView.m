//
//  LYEmptyView.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2017/5/10.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYEmptyView.h"

//每个子控件之间的间距
#define kSubViewMargin 20.f

//描述字体
#define kTitleLabFont [UIFont systemFontOfSize:16.f]

//详细描述字体
#define kDetailLabFont [UIFont systemFontOfSize:14.f]

//按钮字体大小
#define kActionBtnFont  [UIFont systemFontOfSize:14.f]

//按钮高度
#define kActionBtnHeight 40.f
//按钮宽度
#define kActionBtnWidth 120.f
//水平方向内边距
#define kActionBtnHorizontalMargin 30.f

//背景色
#define kBackgroundColor [UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1.f]
//黑色
#define kBlackColor [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]
//灰色
#define kGrayColor [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.f]

@interface LYEmptyView ()

@property (nonatomic, strong) UIImageView *promptImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UIButton    *actionButton;
@property (nonatomic, strong) UIView      *customV;

@end

@implementation LYEmptyView
{
    CGFloat contentMaxWidth; //最大宽度
    CGFloat contentWidth;    //内容物宽度
    CGFloat contentHeight;   //内容物高度
    CGFloat subViweMargin;   //内容物上每个子控件之间的间距
}

- (void)initialize{
    self.actionBtnHeight = 40.f;
    self.actionBtnWidth = 120.f;
    self.actionBtnHorizontalMargin = 30.f;
    self.detailLabMaxLines = 2;
}

- (void)prepare{
    [super prepare];
    
    self.autoShowEmptyView = YES; //默认自动显隐
    self.contentViewY = 1000;     //默认值,用来判断是否设置过content的Y值
}

- (void)setupSubviews{
    [super setupSubviews];
    
    contentMaxWidth = self.emptyViewIsCompleteCoverSuperView ? self.ly_width : self.ly_width - 30.f;
    contentWidth = 0;//内容物宽度
    contentHeight = 0;//内容物高度
    subViweMargin = self.subViewMargin ? self.subViewMargin : kSubViewMargin;
    
    //占位图片
    UIImage *image;
    if (self.imageStr.length) {
        image = [UIImage imageNamed:self.imageStr];
    }
    if(self.image){
        [self setupPromptImageView:self.image];
    }else if (image) {
        [self setupPromptImageView:image];
    } else{
        if (_promptImageView) {
            [self.promptImageView removeFromSuperview];
            self.promptImageView = nil;
        }
    }
    
    //标题
    if (self.titleStr.length) {
        [self setupTitleLabel:self.titleStr];
    }else{
        if (_titleLabel) {
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
        }
    }
    
    //详细描述
    if (self.detailStr.length) {
        [self setupDetailLabel:self.detailStr];
    }else{
        if (_detailLabel) {
            [self.detailLabel removeFromSuperview];
            self.detailLabel = nil;
        }
    }
    
    //按钮
    if (self.btnTitleStr.length) {
        if (self.actionBtnTarget && self.actionBtnAction) {
            [self setupActionBtn:self.btnTitleStr target:self.actionBtnTarget action:self.actionBtnAction btnClickBlock:nil];
        }else if (self.btnClickBlock) {
            [self setupActionBtn:self.btnTitleStr target:nil action:nil btnClickBlock:self.btnClickBlock];
        }else{
            if (_actionButton) {
                [self.actionButton removeFromSuperview];
                self.actionButton = nil;
            }
        }
    }else{
        if (_actionButton) {
            [self.actionButton removeFromSuperview];
            self.actionButton = nil;
        }
    }
    
    //自定义view
    if (self.customView) {
        contentWidth = self.customView.ly_width;
        contentHeight = self.customView.ly_maxY;
    }
    
    ///设置frame
    [self setSubViewFrame];
}

- (void)setSubViewFrame{
    
    //emptyView初始宽高
    CGFloat originEmptyWidth = self.ly_width;
    CGFloat originEmptyHeight = self.ly_height;
    
    CGFloat emptyViewCenterX = originEmptyWidth * 0.5f;
    CGFloat emptyViewCenterY = originEmptyHeight * 0.5f;
    
    //不是完全覆盖父视图时，重新设置self的frame（大小为content的大小）
    if (!self.emptyViewIsCompleteCoverSuperView) {
        self.ly_size = CGSizeMake(contentWidth, contentHeight);
    }
    self.center = CGPointMake(emptyViewCenterX, emptyViewCenterY);
    
    //设置contentView
    self.contentView.ly_size = CGSizeMake(contentWidth, contentHeight);
    if (self.emptyViewIsCompleteCoverSuperView) {
        self.contentView.center = CGPointMake(emptyViewCenterX, emptyViewCenterY);
    } else {
        self.contentView.center = CGPointMake(contentWidth*0.5, contentHeight*0.5);
    }
    
    //子控件的centerX设置
    CGFloat centerX = self.contentView.ly_width * 0.5f;
    if (self.customView) {
        self.customView.ly_centerX      = centerX;
        
    }else{
        _promptImageView.ly_centerX = centerX;
        _titleLabel.ly_centerX       = centerX;
        _detailLabel.ly_centerX = centerX;
        _actionButton.ly_centerX    = centerX;
    }
    
    if (self.contentViewOffset) { //有无设置偏移
        self.ly_centerY += self.contentViewOffset;
        
    } else if (self.contentViewY < 1000) { //有无设置Y坐标值
        self.ly_y = self.contentViewY;
        
    }
    
    //是否忽略scrollView的contentInset
    if (self.ignoreContentInset && [self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        self.ly_centerY -= scrollView.contentInset.top;
        self.ly_centerX -= scrollView.contentInset.left;
        self.ly_centerY += scrollView.contentInset.bottom;
        self.ly_centerX += scrollView.contentInset.right;
    }
}

#pragma mark - ------------------ Setup View ------------------
- (void)setupPromptImageView:(UIImage *)img{
    
    self.promptImageView.image = img;
    
    CGFloat imgViewWidth = img.size.width;
    CGFloat imgViewHeight = img.size.height;
    
    if (self.imageSize.width && self.imageSize.height) {//设置了宽高大小
        if (imgViewWidth > imgViewHeight) {//以宽为基准，按比例缩放高度
            imgViewHeight = (imgViewHeight / imgViewWidth) * self.imageSize.width;
            imgViewWidth = self.imageSize.width;
            
        }else{//以高为基准，按比例缩放宽度
            imgViewWidth = (imgViewWidth / imgViewHeight) * self.imageSize.height;
            imgViewHeight = self.imageSize.height;
        }
    }
    self.promptImageView.frame = CGRectMake(0, 0, imgViewWidth, imgViewHeight);
    
    contentWidth = self.promptImageView.ly_size.width;
    contentHeight = self.promptImageView.ly_maxY;
}

- (void)setupTitleLabel:(NSString *)titleStr{
    
    UIFont *font = self.titleLabFont.pointSize ? self.titleLabFont : kTitleLabFont;
    CGFloat fontSize = font.pointSize;
    UIColor *textColor = self.titleLabTextColor ? self.titleLabTextColor : kBlackColor;
    CGFloat titleMargin = self.titleLabMargin > 0 ? self.titleLabMargin : (contentHeight == 0 ?: subViweMargin);
    CGSize size = [self returnTextWidth:titleStr size:CGSizeMake(contentMaxWidth, fontSize + 5) font:font];
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    self.titleLabel.frame = CGRectMake(0, contentHeight + titleMargin, width, height);
    self.titleLabel.font = font;
    self.titleLabel.text = titleStr;
    self.titleLabel.textColor = textColor;
    
    contentWidth = width > contentWidth ? width : contentWidth;
    contentHeight = self.titleLabel.ly_maxY;
}

- (void)setupDetailLabel:(NSString *)detailStr{
    
    UIColor *textColor = self.detailLabTextColor ? self.detailLabTextColor : kGrayColor;
    UIFont *font = self.detailLabFont.pointSize ? self.detailLabFont : kDetailLabFont;
    CGFloat fontSize = font.pointSize;
    CGFloat maxLines = self.detailLabMaxLines > 0 ? self.detailLabMaxLines : 1;
    CGFloat detailMargin = self.detailLabMargin > 0 ? self.detailLabMargin : (contentHeight == 0 ?: subViweMargin);
    self.detailLabel.font = font;
    self.detailLabel.textColor = textColor;
    self.detailLabel.text = detailStr;
    
    CGFloat width = 0;
    CGFloat height = 0;
    
    //设置行高
    if(self.detailLabLineSpacing){
        
        CGFloat maxHeight = maxLines * (fontSize + 5) + (maxLines-1) * self.detailLabLineSpacing;
        
        NSDictionary *dic = [self sizeWithAttributedString:self.detailLabel.text font:font lineSpacing:self.detailLabLineSpacing maxSize:CGSizeMake(contentMaxWidth, maxHeight)];
        
        NSMutableAttributedString *attStr = dic[@"attributed"];
        NSValue *sizeValue = dic[@"size"];
        CGSize size = sizeValue.CGSizeValue;
        width = size.width;
        height = size.height;
        self.detailLabel.attributedText = attStr;
        
    }
    else{
        
        CGFloat maxHeight = maxLines * (fontSize + 5);
        CGSize size = [self returnTextWidth:detailStr size:CGSizeMake(contentMaxWidth, maxHeight) font:font];//计算得出label大小
        width = size.width;
        height = size.height;
    }
    
    self.detailLabel.frame = CGRectMake(0, contentHeight + detailMargin, width, height);
    
    contentWidth = width > contentWidth ? width : contentWidth;
    contentHeight = self.detailLabel.ly_maxY;
   
}

- (void)setupActionBtn:(NSString *)btnTitle target:(id)target action:(SEL)action btnClickBlock:(LYActionTapBlock)btnClickBlock{
    
    UIFont *font = self.actionBtnFont.pointSize ? self.actionBtnFont : kActionBtnFont;
    CGFloat fontSize = font.pointSize;
    UIColor *titleColor = self.actionBtnTitleColor ?: kBlackColor;
    UIColor *backGColor = self.actionBtnBackGroundColor ?: [UIColor whiteColor];
    UIColor *borderColor = self.actionBtnBorderColor ?: [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f];
    CGFloat borderWidth = self.actionBtnBorderWidth ?: 0;
    CGFloat cornerRadius = self.actionBtnCornerRadius ?: 0;
    CGFloat width = self.actionBtnWidth;
    CGFloat horiMargin = self.actionBtnHorizontalMargin;
    CGFloat height = self.actionBtnHeight;
    CGSize textSize = [self returnTextWidth:btnTitle size:CGSizeMake(contentMaxWidth, fontSize) font:font];//计算得出title文字内容大小
    if (height < textSize.height) {
        height = textSize.height + 4.f;
    }
    
    //按钮的宽
    CGFloat btnWidth = textSize.width;
    if (width) {
        btnWidth = width;
    } else if (horiMargin) {
        btnWidth = textSize.width + horiMargin * 2.f;
    }
    
    //按钮的高
    CGFloat btnHeight = height;
    btnWidth = btnWidth > contentMaxWidth ? contentMaxWidth : btnWidth;
    CGFloat btnMargin = self.actionBtnMargin > 0 ? self.actionBtnMargin : (contentHeight == 0 ?: subViweMargin);
    
    self.actionButton.frame = CGRectMake(0, contentHeight + btnMargin, btnWidth, btnHeight);
    [self.actionButton setTitle:btnTitle forState:UIControlStateNormal];
    self.actionButton.titleLabel.font = font;
    self.actionButton.backgroundColor = backGColor;
    if (self.actionBtnBackGroundGradientColors) [self addGradientWithView:self.actionButton gradientColors:self.actionBtnBackGroundGradientColors];
    [self.actionButton setTitleColor:titleColor forState:UIControlStateNormal];
    self.actionButton.layer.borderColor = borderColor.CGColor;
    self.actionButton.layer.borderWidth = borderWidth;
    self.actionButton.layer.cornerRadius = cornerRadius;
    
    //添加事件
    if (target && action) {
        [self.actionButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self.actionButton addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else if (btnClickBlock) {
        [self.actionButton addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    contentWidth = btnWidth > contentWidth ? btnWidth : contentWidth;
    contentHeight = self.actionButton.ly_maxY;
}

#pragma mark - ------------------ Event Method ------------------
- (void)actionBtnClick:(UIButton *)sender{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

#pragma mark - ------------------ setter ------------------

- (void)setEmptyViewIsCompleteCoverSuperView:(BOOL)emptyViewIsCompleteCoverSuperView{
    _emptyViewIsCompleteCoverSuperView = emptyViewIsCompleteCoverSuperView;
    if (emptyViewIsCompleteCoverSuperView) {
        if (!self.backgroundColor || [self.backgroundColor isEqual:[UIColor clearColor]]) {
            self.backgroundColor = kBackgroundColor;
        }
        [self setNeedsLayout];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark 内容物背景视图 相关
- (void)setSubViewMargin:(CGFloat)subViewMargin{
    if (_subViewMargin != subViewMargin) {
        _subViewMargin = subViewMargin;
        
        [self reSetupSubviews];
    }
}
- (void)setTitleLabMargin:(CGFloat)titleLabMargin{
    if (_titleLabMargin != titleLabMargin) {
        _titleLabMargin = titleLabMargin;
        
        [self reSetupSubviews];
    }
}
- (void)setDetailLabMargin:(CGFloat)detailLabMargin{
    if (_detailLabMargin != detailLabMargin) {
        _detailLabMargin = detailLabMargin;
        
        [self reSetupSubviews];
    }
}
- (void)setActionBtnMargin:(CGFloat)actionBtnMargin{
    if (_actionBtnMargin != actionBtnMargin) {
        _actionBtnMargin = actionBtnMargin;
        
        [self reSetupSubviews];
    }
}
- (void)reSetupSubviews{
    if (_promptImageView || _titleLabel || _detailLabel || _actionButton || self.customView) {//此判断的意思只是确定self是否已加载完毕
        [self setupSubviews];
    }
}
- (void)setContentViewOffset:(CGFloat)contentViewOffset{
    if (_contentViewOffset != contentViewOffset) {
        _contentViewOffset = contentViewOffset;
        
        if (_promptImageView || _titleLabel || _detailLabel || _actionButton || self.customView) {
            self.ly_centerY += self.contentViewOffset;
        }
    }
}
- (void)setContentViewY:(CGFloat)contentViewY{
    if (_contentViewY != contentViewY) {
        _contentViewY = contentViewY;
        
        if (_promptImageView || _titleLabel || _detailLabel || _actionButton || self.customView) {
            self.ly_y = self.contentViewY;
        }
    }
}

#pragma mark 提示图Image 相关
- (void)setImageSize:(CGSize)imageSize{
    if (_imageSize.width != imageSize.width || _imageSize.height != imageSize.height) {
        _imageSize = imageSize;
        
        if (_promptImageView) {
            [self setupSubviews];
        }
    }
}

#pragma mark 描述Label 相关
- (void)setTitleLabFont:(UIFont *)titleLabFont{
    if (_titleLabFont != titleLabFont) {
        _titleLabFont = titleLabFont;
        
        if (_titleLabel) {
            [self setupSubviews];
        }
    }
    
}
- (void)setTitleLabTextColor:(UIColor *)titleLabTextColor{
    if (_titleLabTextColor != titleLabTextColor) {
        _titleLabTextColor = titleLabTextColor;
        
        if (_titleLabel) {
            _titleLabel.textColor = titleLabTextColor;
        }
    }
}

#pragma mark 详细描述Label 相关
- (void)setDetailLabFont:(UIFont *)detailLabFont{
    if (_detailLabFont != detailLabFont) {
        _detailLabFont = detailLabFont;
        
        if (_detailLabel) {
            [self setupSubviews];
        }
    }
}
- (void)setDetailLabMaxLines:(NSInteger)detailLabMaxLines{
    if (_detailLabMaxLines != detailLabMaxLines) {
        _detailLabMaxLines = detailLabMaxLines;
        
        if (_detailLabel) {
            [self setupSubviews];
        }
    }
}
- (void)setDetailLabTextColor:(UIColor *)detailLabTextColor{
    if (_detailLabTextColor != detailLabTextColor) {
        _detailLabTextColor = detailLabTextColor;
        
        if (_detailLabel) {
            _detailLabel.textColor = detailLabTextColor;
        }
    }
}

- (void)setDetailLabLineSpacing:(NSInteger)detailLabLineSpacing{
    if (_detailLabLineSpacing != detailLabLineSpacing) {
        _detailLabLineSpacing = detailLabLineSpacing;
        
        if (_detailLabel) {
            [self setupSubviews];
        }
    }
}

#pragma mark Button 相关
//////////大小位置相关-需要重新布局
- (void)setActionBtnFont:(UIFont *)actionBtnFont{
    if (_actionBtnFont != actionBtnFont) {
        _actionBtnFont = actionBtnFont;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}
- (void)setActionBtnHeight:(CGFloat)actionBtnHeight{
    if (_actionBtnHeight != actionBtnHeight) {
        _actionBtnHeight = actionBtnHeight;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}
- (void)setActionBtnWidth:(CGFloat)actionBtnWidth{
    if (_actionBtnWidth != actionBtnWidth) {
        _actionBtnWidth = actionBtnWidth;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}
- (void)setActionBtnHorizontalMargin:(CGFloat)actionBtnHorizontalMargin{
    if (_actionBtnHorizontalMargin != actionBtnHorizontalMargin) {
        _actionBtnHorizontalMargin = actionBtnHorizontalMargin;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}
//////////其他相关-直接赋值
- (void)setActionBtnCornerRadius:(CGFloat)actionBtnCornerRadius{
    if (_actionBtnCornerRadius != actionBtnCornerRadius) {
        _actionBtnCornerRadius = actionBtnCornerRadius;
        
        if (_actionButton) {
            _actionButton.layer.cornerRadius = actionBtnCornerRadius;
        }
    }
}
- (void)setActionBtnBorderWidth:(CGFloat)actionBtnBorderWidth{
    if (actionBtnBorderWidth != _actionBtnBorderWidth) {
        _actionBtnBorderWidth = actionBtnBorderWidth;
        
        if (_actionButton) {
            _actionButton.layer.borderWidth = actionBtnBorderWidth;
        }
    }
}
- (void)setActionBtnBorderColor:(UIColor *)actionBtnBorderColor{
    if (_actionBtnBorderColor != actionBtnBorderColor) {
        _actionBtnBorderColor = actionBtnBorderColor;
        
        if (_actionButton) {
            _actionButton.layer.borderColor = actionBtnBorderColor.CGColor;
        }
    }
}
- (void)setActionBtnTitleColor:(UIColor *)actionBtnTitleColor{
    if (_actionBtnTitleColor != actionBtnTitleColor) {
        _actionBtnTitleColor = actionBtnTitleColor;
        
        if (_actionButton) {
            [_actionButton setTitleColor:actionBtnTitleColor forState:UIControlStateNormal];
        }
    }
}
- (void)setActionBtnBackGroundColor:(UIColor *)actionBtnBackGroundColor{
    if (actionBtnBackGroundColor != _actionBtnBackGroundColor) {
        _actionBtnBackGroundColor = actionBtnBackGroundColor;
        
        if (_actionButton) {
            [_actionButton setBackgroundColor:actionBtnBackGroundColor];
        }
    }
}
- (void)setActionBtnBackGroundGradientColors:(NSArray<UIColor *> *)actionBtnBackGroundGradientColors
{
    if (actionBtnBackGroundGradientColors.count >= 2) {
        _actionBtnBackGroundGradientColors = [actionBtnBackGroundGradientColors subarrayWithRange:NSMakeRange(0, 2)];
        if (_actionButton) {
            [self addGradientWithView:_actionButton gradientColors:_actionBtnBackGroundGradientColors];
        }
    }
}

#pragma mark - ------------------ getter ------------------
- (UIImageView *)promptImageView{
    if (!_promptImageView) {
        _promptImageView = [[UIImageView alloc] init];
        _promptImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_promptImageView];
    }
    return _promptImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}
- (UIButton *)actionButton{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] init];
        _actionButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_actionButton];
    }
    return _actionButton;
}

#pragma mark - ------------------ Help Method ------------------
- (CGSize)returnTextWidth:(NSString *)text size:(CGSize)size font:(UIFont *)font{
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return textSize;
}

- (NSDictionary *)sizeWithAttributedString:(NSString *)string font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:font}];
    
    CGSize size = [attributedStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    NSDictionary *dic = @{
                          @"attributed":attributedStr,
                          @"size": [NSValue valueWithCGSize:size]
                          };
    return dic;
}

- (void)addGradientWithView:(UIView *)view gradientColors:(NSArray<UIColor *> *)gradientColors
{
    [view setBackgroundColor:[UIColor clearColor]];
    
    NSArray *colors = @[(__bridge id)[gradientColors.firstObject CGColor],
                        (__bridge id)[gradientColors.lastObject CGColor]];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = colors;
    layer.locations = @[@0.3, @0.5, @1.0];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1.0, 0);
    layer.frame = view.bounds;
    layer.masksToBounds = YES;
    layer.cornerRadius = view.frame.size.height * 0.5;
    
    CALayer *firstLayer = self.layer.sublayers.firstObject;
    if ([firstLayer isKindOfClass:[CAGradientLayer class]]) {
        [view.layer replaceSublayer:firstLayer with:layer];
    } else {
        [view.layer insertSublayer:layer atIndex:0];
    }
}

@end
