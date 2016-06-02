//
//  YYAlterViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/16.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYAlterViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YYUsersViewController.h"
#import "YYUser.h"

@interface YYAlterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *rpwdText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation YYAlterViewController
- (IBAction)alterring:(id)sender {
    NSString *password = _passwordText.text;
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
    
    if (_rpwdText.text.length == 0) {
        [MBProgressHUD showError:@"请输入确认密码"];
        return;
    }
    
    if ([password compare: _rpwdText.text]) {
        [MBProgressHUD showError:@"密码不一致"];
        return;
    }
    
    NSString *name = _nameText.text;
    if (name.length == 0) {
        [MBProgressHUD showError:@"请输入姓名"];
        return;
    }
    
    NSString *phone = _phoneText.text;
    if (phone.length == 0) {
        [MBProgressHUD showError:@"请输入电话号码"];
        return;
    }
    if (phone.length != 11) {
        [MBProgressHUD showError:@"号码长度不正确!"];
        return;
    }
    
    YYUser *user = [YYUser shareUser];
    NSString *account = user.account;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/users/modify?account=%@&password=%@&name=%@&phone=%@",account,password,name,phone];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }
//        NSLog(@"--%@",data);
    if (!data) {
        [MBProgressHUD showError:@"修改---访问失败"];
        return ;
    }
//    NSLog(@"%@",data);;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",dict);
    
    if ([dict[@"message"] isEqualToString:@"success"]) {
        [YYUser exit];
        [MBProgressHUD showSuccess:@"修改成功请重新登录"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [MBProgressHUD showError:@"修改失败"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarController *tabbar = [self.navigationController parentViewController];
    tabbar.tabBar.hidden = YES;

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
