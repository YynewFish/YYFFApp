//
//  YYShowViewController.h
//  YYFFApp
//
//  Created by 余跃 on 16/5/16.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchModel.h"

@interface YYShowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;

@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UITextView *describeView;

@property (nonatomic, strong) searchModel *model;


@end
