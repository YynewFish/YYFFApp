//
//  YYShowViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/16.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYShowViewController.h"
#import "YYCommentViewController.h"
#import "YYShowCommentViewController.h"
#import "YYcomment.h"
#import "YYUser.h"

#import "MBProgressHUD+MJ.h"
#import "searchModel.h"

@interface YYShowViewController ()



@end

@implementation YYShowViewController
//id _showViewController;


- (IBAction)comment:(id)sender {
    //评价
    YYUser *user = [YYUser shareUser];
    if (user.name == nil) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    
    
    
    YYCommentViewController *yy = [[YYCommentViewController alloc]init];

    yy.model = self.model;
    
    [self.navigationController pushViewController:yy animated:YES];
    
}

- (IBAction)showComment:(id)sender {
    //查看评价
    YYUser *user = [YYUser shareUser];
    if (user.name == nil) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    [YYcomment shareCommentsWithName:_nameLable.text];
    NSArray *com =[YYcomment shareCommentArray];
    if (com == nil) {
        return;
    }
    if (com.count==0) {
        [MBProgressHUD showError:@"没有对此对象的评论"];
        return;
    }
    YYShowCommentViewController *yy = [[YYShowCommentViewController alloc]init];
    [self.navigationController pushViewController:yy animated:YES];
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image = [UIImage imageNamed:self.model.imageUrl];
    _nameLable.text = self.model.name;
    NSLog(@"%@",self.model.name);

    NSLog(@"--%@",_nameLable.text);
    _cityLable.text = self.model.city;
    _addressLable.text = self.model.address;
    _describeView.text = self.model.describe;
    
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = YES;
    
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
