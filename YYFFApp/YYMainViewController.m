//
//  YYMainViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/8.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYMainViewController.h"
#import "YYShowViewController.h"
#import "SearchCell.h"
#import "TGModel.h"
//#import "HMTg.h"

#define kImageCount     5

@interface YYMainViewController () <UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tgs;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YYMainViewController

//id _mainViewController;
//
//+(id)allocWithZone:(struct _NSZone *)zone{
//    
//    if (_mainViewController == nil) {
//        _mainViewController = [super allocWithZone:zone];
//    }
//    return _mainViewController;
//}

+(instancetype)shareMainViewController{
    return [[self alloc]init];
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 70, 355, 130)];
        _scrollView.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:_scrollView];
        
        // 取消弹簧效果
        _scrollView.bounces = NO;
        
        // 取消水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 要分页
        _scrollView.pagingEnabled = YES;
        
        // contentSize
        _scrollView.contentSize = CGSizeMake(kImageCount * _scrollView.bounds.size.width, 0);
        
        // 设置代理
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControl = [[UIPageControl alloc] init];
        // 总页数
        _pageControl.numberOfPages = kImageCount;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:kImageCount];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, 180);
        
        // 设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        [self.view addSubview:_pageControl];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

// 分页控件的监听方法
- (void)pageChanged:(UIPageControl *)page
{
//    NSLog(@"%d", page.currentPage);
    
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (UITableView *)tableView
{
    
    if (_tableView == nil) {
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 205, 375, 400) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = NO;

}


// 视图加载完成调用，通常用来设置数据
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self tableView];
    
    // 设置行高
    self.tableView.rowHeight = 105;
    
    
    // 设置图片
    for (int i = 0; i < kImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        imageView.image = image;
        
        [self.scrollView addSubview:imageView];
    }
    
    // 计算imageView的位置
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        
        // 调整x => origin => frame
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        
        imageView.frame = frame;
    }];
    //    NSLog(@"%@", self.scrollView.subviews);
    
    // 分页初始页数为0
    self.pageControl.currentPage = 0;
    
    // 启动时钟
    [self startTimer];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (self.pageControl.currentPage + 1) % kImageCount;
    self.pageControl.currentPage = page;
    
//    NSLog(@"%d", self.pageControl.currentPage);
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.pageControl];
}

#pragma mark - ScrollView的代理方法
// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 停下来的当前页数
    //NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.pageControl.currentPage = page;
}

#pragma mark - 数据源方法

//-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//  
//}


// 每个分组中的数据总数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"每个分组的数据总数 %d", self.heros.count);
    
    NSArray *array = [TGModel shareModelArray];
    return array.count;
}

/**
 UITableViewCellStyleDefault,   默认类型 标题+可选图像
 UITableViewCellStyleValue1,    标题+明细+图像
 UITableViewCellStyleValue2,    不显示图像，标题+明细
 UITableViewCellStyleSubtitle   标题+明细+图像
 */
// 告诉表格每个单元格的明细信息
// 此方法的调用频率非常高!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"表格行明细 %d", indexPath.row);
    

    static NSString *ID = @"Cell";
    
    // 1. 取缓存池查找可重用的单元格
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2. 如果没有找到
    if (cell == nil) {

        // 创建单元格，并设置cell有共性的属性
        // 实例化新的单元格
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 背景颜色，会影响到未选中表格行的标签背景
        //        cell.backgroundColor = [UIColor redColor];
        // 在实际开发中，使用背景视图的情况比较多
        // 背景视图，不需要指定大小，cell会根据自身的尺寸，自动填充调整背景视图的显示
        //        UIImage *bgImage = [UIImage imageNamed:@"img_01"];
        //        cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
        //        UIView *bgView = [[UIView alloc] init];
        //        bgView.backgroundColor = [UIColor yellowColor];
        //        cell.backgroundView = bgView;
        // 没有选中的背景颜色
        // 选中的背景视图
        //        UIImage *selectedBGImage = [UIImage imageNamed:@"img_02"];
        //        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:selectedBGImage];
    }
    
    NSArray *array = [TGModel shareModelArray];
    TGModel *model = array[indexPath.row];
//    HMTg *tg = self.tgs[indexPath.row];
    
    // 标题
    cell.nameLable.text = model.name;
    //NSLog(@"%s",tg.title);
    // 明细信息
    if ([model.type isEqualToString:@"food"]) {
        cell.desLable.text = model.city;
    }else{
        cell.desLable.text = model.address;
    }
    
  
    cell.imageUrl.image = [UIImage imageNamed:model.imageUrl];
    
    return cell;
}

- (void)switchChanged:(UISwitch *)sender
{
    //NSLog(@"%s %@", __func__, sender);
}

#pragma mark - 代理方法
// accessoryType为按钮时，点击右侧按钮的监听方法
// 此方法不会触发行选中，跟行选中各自独立
// 只是为accessoryType服务，对自定义控件不响应
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%s %@", __func__, indexPath);
}

// 取消选中某一行，极少用，极容易出错！
// didDeselectRowAtIndexPath
// didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%s %@", __func__, indexPath);
}

// 选中了某一行，有箭头的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"选取了 %ld行",indexPath.row);

    NSArray *array = [TGModel shareModelArray];
    TGModel *yy = array[indexPath.row];
    YYShowViewController *showVc = [YYShowViewController new];
    showVc.model = yy;
//    NSLog(@"=%@",yy.name);
    [self.navigationController pushViewController:showVc animated:YES];
   // NSLog(@"选取了 %@",self.tgs[indexPath.row]);
}

@end
