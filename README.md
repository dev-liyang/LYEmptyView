# LYEmptyView
空内容界面占位视图，支持TableView、CollectionView，高强度自定义，基于runtime调用灵活，
一行代码就可集成一个简单的空内容视图，低耦合，使用加上一行代码，不使用删掉即可

## 一、Demo展示

![](https://github.com/yangli-dev/LYEmptyView/blob/master/images/ImitateOtherApp.png)

## 二、集成方式

> 1.支持Cocoapods方式: pod 'LYEmptyView'<br>
2.手动下载导入,将LYEmptyView文件夹，导入你的工程即可

在使用的地方导入头文件：#import "LYEmptyViewHeader.h"


## 三、使用参考

### 1.example1-一行代码集成简易的空视图

```
1.框架方法
self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData" titleStr:@"暂无数据，点击重新加载" detailStr:@""];

//2.二次封装方法，调用更简单
//self.tableView.ly_emptyView = [MyDIYEmpty diyEmptyView];
```
完全低耦合，在你的项目中加入这一行代码就可集成<br>
不管项目中是reloadData方法刷UI还是insert、delete等方式刷UI,不需做其他任何操作，只需这一行代码就可实现以下效果

![](https://github.com/yangli-dev/LYEmptyView/blob/master/images/example1.gif)

