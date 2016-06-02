//
//  YYCommentViewController.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/19.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYCommentViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YYUser.h"

@interface YYCommentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;

@property (weak, nonatomic) IBOutlet UITextField *commontText;

@end

@implementation YYCommentViewController


- (IBAction)comment:(id)sender {
    //评论
    if (_commontText.text.length == 0) {
        
        [MBProgressHUD showError:@"请输入评论内容"];
        return;
    }
    
    YYUser *yy = [YYUser shareUser];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/comments/write?name=%@&content=%@&username=%@",_model.name,_commontText.text,yy.name];
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
        [MBProgressHUD showError:@"链接失败"];
        return ;
    }
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameLabel.text = self.model.name;
    _imageUrl.image = [UIImage imageNamed:self.model.imageUrl];
    
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
