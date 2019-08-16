# LYEmptyView
不需要遵循协议，不需要设置代理，不需要实现代理方法，只需这一句代码，就可为一个UITableViwe/UICollectionView集成空白页面占位图。<br>`self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];`

#### 注意点:
#### 1.除UITableViwe/UICollectionView外，这些View(包括UIScrollView)没有DataSource，代码层面无法判断有无数据，需手动管理显示隐藏，调用示例请移步示例8

| 特点  | 描述 |
| ---------- | -----------|
| 与项目完全解耦 | 在需要集成的界面中加入一行代码即可集成，与原代码没有一点耦合度  |
| 0学习成本 | 无需关心视图的显示隐藏时机，只需加入一行代码即可，框架监听了系统刷新UI的方法，其内部计算后自动进行显示隐藏 |
| 调用简单 | 利用分类+runtime，使调用非常简便 |
| 高度自定义   | 利用继承特性，可对框架进行二次封装，使自定义更简便  |
| 支持全部的刷新方法 | reload...、insert...、delete...等方法。你的项目中调用这些刷新方法时，该框架都会自动根据DataSource自动进行计算判断是否显示emptyView |

# 目录
* [一、效果展示](#效果展示)<br>
* [二、集成方式](#集成方式)<br>
* [三、使用参考示例](#使用参考示例)<br>
    * [1.一行代码集成空内容视图](#一行代码集成空内容视图)<br>
    * [2.自由选择空内容元素](#自由选择空内容元素)<br>
    * [3.自定义空内容元素](#自定义空内容元素)<br>
    * [4.自定义元素的UI样式](#自定义元素的UI样式)<br>
    * [5.二次封装](#二次封装)<br>
    * [6.延迟显示emptyView](#延迟显示emptyView)<br>
    * [7.特殊需求，手动控制emptyView的显示隐藏](#特殊需求，手动控制emptyView的显示隐藏)<br>
    * [8.普通view调用示例](#普通view调用示例)<br>
    * [9.占位图完全覆盖父视图](#占位图完全覆盖父视图)<br>

## <a id="效果展示"></a>一、效果展示

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/ImitateOtherApp.png)

## <a id="集成方式"></a>二、集成方式

1.Cocoapods方式集成: `pod 'LYEmptyView'`<br>
使用时导入头文件 `#import <LYEmptyView/LYEmptyViewHeader.h>`
<br><br>
2.手动下载集成: 将LYEmptyView文件夹，导入你的工程<br>
使用时导入头文件：`#import "LYEmptyViewHeader.h"`


## <a id="使用参考示例"></a>三、使用参考示例

### <a id="一行代码集成空内容视图"></a>1.一行代码集成空内容视图

```Objective-C
//框架方法
self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                        titleStr:@"暂无数据，点击重新加载"
                                                       detailStr:@""];
```

PS:可对库进行二次封装，调用更简洁（二次封装方法在下面的示例5中会讲到）
```Objective-C
//二次封装方法，调用简洁
self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
```

完全低耦合，在你的项目中加入这一行代码就可集成<br>
不管项目中是reloadData方法刷UI还是insert、delete等方式刷UI,不需做其他任何操作，只需这一行代码就可实现以下效果

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example1.gif)

### <a id="自由选择空内容元素"></a>2.自由选择空内容元素
```Objective-C
交互事件可选择SEL或block方式
self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"noData"
                                                              titleStr:@"无数据"
                                                             detailStr:@"请稍后再试!"
                                                           btnTitleStr:@"重新加载"
                                                                target:target
                                                                action:action];
self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"noData"
                                                              titleStr:@""
                                                             detailStr:@""
                                                           btnTitleStr:@""
                                                         btnClickBlock:^{}];
//    imageStr    : 占位图片
//    titleStr    : 标题
//    detailStr   : 详细描述
//    btnTitleStr : 按钮标题                                                         
```
框架提供四个元素，传入相应元素的字符串即可显示对应元素（按钮的显示前提是传入target，action或btnClickBlock）
可根据项目需求，自由进行组合，如下只展示了部分组合效果

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example2.png)

### <a id="自定义空内容元素"></a>3.自定义空内容元素
特殊情况下，如果空内容状态布局不满足需求时，可进行自定义<br>
通过方法`  + (instancetype)emptyViewWithCustomView:(UIView *)customView;`<br>
传入一个View 即可创建一个自定义的emptyView
```Objective-C
self.tableView.ly_emptyView = [LYEmptyView emptyViewWithCustomView:customView];
```

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example3.png)


### <a id="自定义元素的UI样式"></a>4.自定义元素的UI样式
这里自定义UI样式需要很多代码，别担心，在示例5中会讲解二次封装的方式，封装后调用时就只需要一行代码了 ^_^
```Objective-C
  //初始化一个emptyView
  LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"noData"
                                                           titleStr:@"无数据"
                                                          detailStr:@"请稍后再试!"
                                                        btnTitleStr:@"重新加载"
                                                      btnClickBlock:^{}];
  //元素竖直方向的间距
  emptyView.subViewMargin = 20.f;
  //标题颜色
  emptyView.titleLabTextColor = MainColor(90, 180, 160);
  //描述字体
  emptyView.detailLabFont = [UIFont systemFontOfSize:17];
  //按钮背景色
  emptyView.actionBtnBackGroundColor = MainColor(90, 180, 160);

  //设置空内容占位图
  self.tableView.ly_emptyView = emptyView;
```
>这里只列举了一些常用的属性，更多属性请到LYEmptyView.h查看

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example4.png)
### <a id="二次封装"></a>5.二次封装
第4小节的示例代码，修改emptyView的样式需要一个个属性单独去改，如果项目中每个界面都这么写就显得很麻烦，而且不易维护<br>
解决办法是对库进行二次封装，二次封装后，对UI样式单独管理，方便维护<br>

##### 1)新建一个类继承自LYEmptyView，例如demo中的MyDIYEmpty
##### 2)重写`- (void)prepare` 方法，并修改想要改变的元素的UI样式
```Objective-C
- (void)prepare{
    [super prepare];
    
    self.titleLabFont = [UIFont systemFontOfSize:25];
    self.titleLabTextColor = MainColor(90, 180, 160);
    
    self.detailLabFont = [UIFont systemFontOfSize:17];
    self.detailLabTextColor = MainColor(180, 120, 90);
    self.detailLabMaxLines = 5;
    
    self.actionBtnBackGroundColor = MainColor(90, 180, 160);
    self.actionBtnTitleColor = [UIColor whiteColor];
}
```
操作上面的两步就可实现对样式的单独管理<br>
调用方法不变，只是调用的类变成了MYDiyEmpty
```Objective-C
self.tableView.ly_emptyView = [MyDIYEmpty emptyActionViewWithImageStr:@"noData"
                                                             titleStr:@"无数据"
                                                            detailStr:@"请稍后再试!"
                                                          btnTitleStr:@"重新加载"
                                                        btnClickBlock:^{}];
```
##### 3)进一步封装显示的元素内容，比如无数据状态图、无网络状态图<br>
在MyDIYEmpty.h定义方法`+ (instancetype)diyNoDataEmpty;`<br>
在MyDIYEmpty.m实现方法
```Objective-C
+ (instancetype)diyNoDataEmpty{
    return [MyDIYEmpty emptyViewWithImageStr:@"nodata"
                                    titleStr:@"暂无数据"
                                   detailStr:@"请检查您的网络连接是否正确!"];
}
```
>经过3步封装，自定义了UI样式，使管理更方便，使调用更简洁<br>
self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];

### <a id="延迟显示emptyView"></a>6.延迟显示emptyView
如示例1图，框架自动根据DataSource计算是否显示emptyView，在空页面发起网络请求时，DataSource肯定为空，会自动显示emptyView，有的产品需求可能不希望这样，希望发起请求时暂时隐藏emptyView。
本框架提供了两个方法可实现此需求，两个方法都是scrollView的分类，调用非常方便
```Objective-C
 /**
   一般用于开始请求网络时调用，ly_startLoading调用时会暂时隐藏emptyView
   当调用ly_endLoading方法时，ly_endLoading方法内部会根据当前的tableView/collectionView的
   DataSource来自动判断是否显示emptyView
 */
- (void)ly_startLoading;

 /**
   在想要刷新emptyView状态时调用
   注意:ly_endLoading 的调用时机，有刷新UI的地方一定要等到刷新UI的方法之后调用，
   因为只有刷新了UI，view的DataSource才会更新，故调用此方法才能正确判断是否有内容。
 */
- (void)ly_endLoading;
```

*注意点:使用这两个方法，请先将emptyView的autoShowEmptyView属性置为NO，关闭自动显隐

以下是调用示例（具体细节可参看demo中的demo2）
```Objective-C
//1.先设置样式
self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
//2.关闭自动显隐（此步可封装进自定义类中，相关调用就可省去这步）
self.tableView.ly_emptyView.autoShowEmptyView = NO;
//3.网络请求时调用
[self.tableView ly_startLoading];
//4.刷新UI时调用（保证在刷新UI后调用）
[self.tableView ly_endLoading];
```

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example6.gif)

### <a id="特殊需求，手动控制emptyView的显示隐藏"></a>7.特殊需求，手动控制emptyView的显示隐藏
在某些特殊界面下，有的tableView/collectionView有固定的一些死数据，其它的数据根据网络加载，这时根据以上的示例方法可能达不到这需求。<br>
本框架提供另外的两个方法来解决这个问题。

```Objective-C
/**
 手动调用显示emptyView
 */
- (void)ly_showEmptyView;

/**
 手动调用隐藏emptyView
 */
- (void)ly_hideEmptyView;
```

*注意点:使用这两个方法，请先将emptyView的autoShowEmptyView属性置为NO，关闭自动显隐

以下是调用示例（具体细节可参看demo中的demo4）
```Objective-C
//1.先设置样式
self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
//2.关闭自动显隐（此步可封装进自定义类中，相关调用就可省去这步）
self.tableView.ly_emptyView.autoShowEmptyView = NO;
//3.显示emptyView
[self.tableView ly_showEmptyView];
//4.隐藏emptyView
[self.tableView ly_hideEmptyView];
```

![](https://github.com/dev-liyang/LYEmptyView/blob/master/images/example7.gif)

### <a id="普通view调用示例"></a>8.普通view调用示例
因普通view(包括scrollView)没有DataSource，代码层面无法判断view上有无数据，所以view想要实现占位图，
还需通过两个方法来手动控制emptyView的显示和隐藏。
以下是调用示例
```Objective-C
//1.先设置样式
self.view.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
//2.显示emptyView
[self.view ly_showEmptyView];
//3.隐藏emptyView
[self.view ly_hideEmptyView];
```
### <a id="占位图完全覆盖父视图"></a>9.占位图完全覆盖父视图
每个项目需求不同，有的占位图内容多大，占位图就多大，这种情况是默认的，不用设置属性。而有的占位图想要和父视图一样大，以达到覆盖住父视图的目的，这种情况下将LYEmptyView的emptyViewIsCompleteCoverSuperView属性值设置为YES即可。
```Objective-C
DemoEmptyView *emptyView = [DemoEmptyView diyEmptyView];
emptyView.emptyViewIsCompleteCoverSuperView = YES;//完全覆盖父视图，背景色默认为浅白色，可自行设置
//emptyView.backgroundColor = [UIColor redColor];//自己设置背景色为红色，此设置也可封装到公共的地方（DemoEmptyView），就不用每次都单独设置了
self.tableView.ly_emptyView = emptyView;
```

## 更新记录

### 2019-08-16 (pod V1.3.0)
* 1.detailLab添加行间距属性
* 2.每个子控件可单独设置间距
* 3.actionBtn添加渐变背景颜色属性
* 4.更改添加emptyView时其显隐的逻辑

### 2019-07-04 (pod V1.2.5)
* 1.新增属性:按钮宽度actionBtnWidth
* 2.修改属性默认值:按钮的圆角actionBtnCornerRadius默认改为0

### 2019-06-18 (pod V1.2.4)
* 1.将点击重试事件加到emptyView上（当设置empty完全覆盖父视图时，就可实现点击屏幕重试的效果）
* 2.swift项目中imageNamed:方法string为nil时崩溃解决

### 2018-12-04 (pod V1.2.3)
* 1.fix bug：当子控件的文字被设置为空并再次设置为非空时, 子控件无法正常显示
* 2.新增属性：ignoreContentInset，是否忽略scrollView的contentInset

### 2018-09-11 (pod V1.2.2)
* 新增构造方法，具体请查看LYEmptyBaseView.h

### 2018-08-22 (pod V1.2.1)
* 大神的建议，不要手动调用layoutSubviews。优化baseView里setter方法调用的重绘机制，使用setNeedsLayout更加优美

### 2018-07-31 (pod V1.2.0)
* 新增属性：emptyViewIsCompleteCoverSuperView, 占位图是否完全覆盖父视图

### 2018-05-11 (pod V1.1.0)
* 新增普通View可设置占位图，实现所有的View都能集成占位图

### 2018-03-26 (pod V1.0.3)
* 添加reloadSections、reloadRows、reloadItems 等方法的监听
* emptyBaseView setter 方法bug fix

### 2018-02-09 (pod V1.0.2)
* 解决只是在导入本框架的情况下，导致UIScrollView上的内容不显示的bug


## 技术交流
本人QQ:944801216<br>
技术交流群:818290484<br>
大家有任何的问题和建议，可以联系我，我一定尽力为大家解决问题，也可以进群和大家一起交流。
