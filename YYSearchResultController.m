//
//  YYSearchResultController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/20.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYSearchResultController.h"
#import "YYShowViewController.h"
#import "SearchModel.h"
#import "SearchCell.h"

@interface YYSearchResultController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YYSearchResultController

- (UITableView *)tableView
{
    
    if (_tableView == nil) {
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = YES;
    
    [self tableView];
    
    // 设置行高
    self.tableView.rowHeight = 105;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSArray *array = [searchModel shareModelArray];
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
    
    // 0. 可重用标示符字符串
    // static静态变量，能够保证系统为变量在内存中只分配一次内存空间
    // 静态变量，一旦创建，就不会被释放，只有当应用程序被销毁时，才会释放！
    static NSString *ID1 = @"Cell1";
    
    // 1. 取缓存池查找可重用的单元格
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
    
    // 2. 如果没有找到
    if (cell == nil) {
        
        // 实例化新的单元格
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
        
        // 右侧箭头
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    // 设置单元格内容
    NSArray *array = [searchModel shareModelArray];
     searchModel *model = array[indexPath.row];
    
    cell.nameLable.text = model.name;
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
    //    NSLog(@"选取了 %ld",indexPath.row);
    //    NSLog(@"选取了 %@",indexPath);
    // NSLog(@"选取了 %@",self.tgs[indexPath.row]);
    NSArray *array = [searchModel shareModelArray];

    YYShowViewController *showVc = [YYShowViewController new];
    showVc.model = array[indexPath.row];
    [self.navigationController pushViewController:showVc animated:YES];
        
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
