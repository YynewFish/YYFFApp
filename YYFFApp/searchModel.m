//
//  searchModel.m
//  YYFFApp
//
//  Created by 余跃 on 16/4/17.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "searchModel.h"
#import "MBProgressHUD+MJ.h"

@implementation searchModel
static id _modelArray;

-(instancetype)initWithDict:(NSDictionary*)dict;{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)shareModelArray{
//    if (_modelArray==nil) {
//        return nil;
//    }
    return _modelArray;
}

+(instancetype)shareWithDict:(NSDictionary*)dict{
    
    return [[self alloc] initWithDict:dict];
}

+(instancetype )searchWithWord:(NSString*)word{
    

       NSMutableArray *Array = [[NSMutableArray alloc]init];
 
    
    
    if ([self requestWithWord:word AndType:@"food"AndFiler:@"city"]) {

        [Array addObjectsFromArray:[self requestWithWord:word AndType:@"food"AndFiler:@"city"]];
        
    }
    if ([self requestWithWord:word AndType:@"food"AndFiler:@"name"]) {
        
        [Array  addObjectsFromArray:[self requestWithWord:word AndType:@"food"AndFiler:@"name"]];
        
    }
    if ([self requestWithWord:word AndType:@"restaurant"AndFiler:@"city"]) {
        
        [Array  addObjectsFromArray:[self requestWithWord:word AndType:@"restaurant"AndFiler:@"city"]];
        
    }
    if ([self requestWithWord:word AndType:@"restaurant"AndFiler:@"name"]) {
        
        [Array  addObjectsFromArray:[self requestWithWord:word AndType:@"restaurant"AndFiler:@"name"]];
        
    }
    _modelArray = Array;
    
    return _modelArray ;
}

+(instancetype)requestWithWord:(NSString*)word AndType:(NSString*)type AndFiler:(NSString*)filer{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/microblog/api/search?word=%@&type=%@&filter=%@",word,type,filer];
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
        [MBProgressHUD showError:[NSString stringWithFormat:@"---访问失败-%@-%@-%@",word,type,filer]];
        return nil;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"--%@",dict);
    
    NSArray *array = dict[@"result"];
//    NSLog(@"--%@",array);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
//        NSLog(@"--%@",dict[@"name"]);
        [arrayM addObject:[self shareWithDict:dict]];
    }
//    NSLog(@"--%@",arrayM);
    return arrayM;
    
}


@end
