//
//  YYcomment.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/20.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYcomment.h"
#import "MBProgressHUD+MJ.h"

@implementation YYcomment

id _commentArray;

-(instancetype)initWithDict:(NSDictionary*)dict;{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)shareWithDict:(NSDictionary*)dict{
    
    return [[self alloc] initWithDict:dict];
}

+(id)shareCommentArray{

    return _commentArray;
}

+(void)shareCommentsWithName:(NSString*)name{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/comments/search?name=%@",name];
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
        [MBProgressHUD showError:[NSString stringWithFormat:@"---访问失败-%@",name]];
        return ;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //    NSLog(@"--%@",dict);
    
    NSArray *array = dict[@"result"];
    //    NSLog(@"--%@",array);
    
    for (NSDictionary *dict in array) {
        //        NSLog(@"--%@",dict[@"name"]);
        [arrayM addObject:[self shareWithDict:dict]];
    }
    _commentArray = arrayM;
    
}

@end
