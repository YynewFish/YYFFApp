//
//  YYSearchViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/4/9.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYSearchViewController.h"
#import "YYSearchResultController.h"
#import "YYUser.h"

#import "searchModel.h"
#import "MBProgressHUD+MJ.h"

@interface YYSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITextView *descText;
@property (weak, nonatomic) IBOutlet UIImageView *descImage;

@end

@implementation YYSearchViewController
- (IBAction)search:(UIButton *)sender {
    
    YYUser *yy = [YYUser shareUser];
    if (yy.name ==nil) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    NSString *word = self.searchText.text;
    if (word.length == 0) {
        [MBProgressHUD showError:@"请输入搜索信息"];
        return;
    }
//    NSLog(@"%@",word);
    NSArray *model = [searchModel searchWithWord:word];
    if (model.count==0) {
        [MBProgressHUD showError:@"未收录相关信息"];
        return;
    }
//    for (searchModel * mod in model) {
//        NSLog(@"%@",mod.name);
//    }
    
    
    YYSearchResultController *showVc = [[YYSearchResultController alloc]init];
//    [mainVc reloadInputViews];
    [self.navigationController pushViewController:showVc animated:YES];
        


        return;
}
    
    
//    self.descImage.image = [UIImage imageNamed:@"img_01"];
//    self.descText.text = @"测试结果";
    //[self reloadInputViews];

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
