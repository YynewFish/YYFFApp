//
//  loginViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/4/7.
//  Copyright (c) 2016年 余跃. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "loginViewController.h"
#import "YYZcViewController.h"
#import "YYMainViewController.h"
#import "YYUser.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation loginViewController

- (IBAction)login:(id)sender {
    NSString *account = self.username.text;
    if (account.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    
    NSString *password = self.pwd.text;
    if (password.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/users/login?account=%@&password=%@",account,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }
    //    NSLog(@"--%@",data);
    if (!data) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"---访问网络失败---"]];
        return ;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
//    NSLog(@"--%@",dict);
//    NSLog(@"---%@",dict[@"result"]);
//    NSLog(@"--%@",NULL);
//    NSLog(@"--%@",[dict[@"result"] class]);
    NSString *xx = [NSString stringWithFormat:@"%@",[dict[@"result"] class]];
    if ([xx isEqualToString:@"NSNull"]) {
        
        [MBProgressHUD showError:@"账号或密码错误"];

    }else{
        
        
        YYUser *user = [YYUser shareUser];
        [user makeWithDict:dict[@"result"]];
        
        [MBProgressHUD showSuccess:@"登录成功"];
        
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}


- (IBAction)jumpZcVc:(id)sender {
    
    YYZcViewController *zcVc = [[YYZcViewController alloc] init];
    [self.navigationController pushViewController:zcVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = YES;

    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
