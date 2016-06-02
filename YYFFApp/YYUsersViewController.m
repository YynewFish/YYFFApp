//
//  YYUsersViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/9.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYUsersViewController.h"
#import "loginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YYAlterViewController.h"
#import "YYUser.h"

@interface YYUsersViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *userThreeLable;

@end

@implementation YYUsersViewController

- (IBAction)login:(id)sender {
    
    YYUser *user = [YYUser shareUser];
    if (user.name!=nil) {
        [MBProgressHUD showError:@"已登录!"];
        return;
    }
    loginViewController *loginVc = [[loginViewController alloc] init];
    loginVc.navigationItem.title =@"登录";
    [self.navigationController pushViewController:loginVc animated:YES];
}


- (IBAction)alter:(id)sender {
    
    YYUser *user = [YYUser shareUser];
    if (user.name == nil) {
        [MBProgressHUD showError:@"请先登录!"];
        return;
    }else{
        YYAlterViewController *alterVc = [[YYAlterViewController alloc]init];
        alterVc.navigationItem.title = @"信息修改";
        [self.navigationController pushViewController: alterVc animated:YES];
    
    }
    
    
    
}

- (IBAction)exit:(id)sender {
    
    YYUser *user = [YYUser shareUser];
    if (user.name==nil) {
        [MBProgressHUD showError:@"未登录!"];
        return;
    }
    
    self.userNameLable.text = @"请登录";
    self.phoneLable.text = @"";
    self.userThreeLable.text = @"";
    
    [YYUser exit];
    
    [MBProgressHUD showSuccess:@"注销成功"];
}

-(void)exitUser{
    
    
    self.userNameLable.text = @"请登录";
    self.phoneLable.text = @"";
    self.userThreeLable.text = @"";

}

-(void)setUser:(YYUser*)user{
    
    
    self.userNameLable.text = user.name;
    self.phoneLable.text = user.phone;
    NSLog(@"%@",user.phone);
    self.userThreeLable.text = @"有你更精彩";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = NO;
    YYUser *user = [YYUser shareUser];
    if (user.name ==nil) {
        [self exitUser];
    }else{
        
        [self setUser:user];
    }
    
    
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
