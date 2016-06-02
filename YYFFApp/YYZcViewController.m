//
//  YYZcViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/7.
//  Copyright (c) 2016年 余跃. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "YYZcViewController.h"

@interface YYZcViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *rpwd;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@end

@implementation YYZcViewController
//注册
- (IBAction)register:(id)sender {
    
    NSString *account = self.userId.text;
    if (account.length == 0) {
        [MBProgressHUD showError:@"请输入账号"];
        return;
    }
    if (account.length < 3) {
        [MBProgressHUD showError:@"账号过短"];
        return;
    }
    if (account.length > 12) {
        [MBProgressHUD showError:@"账号过长"];
        return;
    }
    
    NSString *password= self.pwd.text;
    if (password.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    if (password.length < 5) {
        [MBProgressHUD showError:@"密码过短"];
        return;
    }
    if (password.length > 12) {
        [MBProgressHUD showError:@"密码过长"];
        return;
    }
    
    NSString *rpwdText = self.rpwd.text;
    if (rpwdText.length == 0) {
        [MBProgressHUD showError:@"请输入确认密码"];
        return;
    }
    
    if ([password compare: rpwdText]) {
        [MBProgressHUD showError:@"密码不一致"];
        return;
    }
    
    
    NSString *name = self.userName.text;
    if (name.length == 0) {
        [MBProgressHUD showError:@"请输入姓名"];
        return;
    }
    
    NSString *phone = self.phone.text;
    if (phone.length == 0) {
        [MBProgressHUD showError:@"请输入手机号!"];
        return;
    }
    if (phone.length != 11) {
        [MBProgressHUD showError:@"号码长度不正确!"];
        return;
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/users/registe?account=%@&password=%@&name=%@&phone=%@",account,password,name,phone];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }
    //    NSLog(@"--%@",data);
    if (!data) {
        [MBProgressHUD showError:@"注册---访问失败"];
        return ;
    }    //NSLog(@"%@",data);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",dict);
    if (![dict[@"message"]compare:@"success"]) {
        [MBProgressHUD showSuccess:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
        //        YYMainViewController *ymVc = [[YYMainViewController alloc] init];
        //        [self.navigationController pushViewController:ymVc animated:YES];
    }else if (![dict[@"message"]compare:@"account is exist."]){
        [MBProgressHUD showSuccess:@"用户名已存在"];
        return;
    }
    
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
