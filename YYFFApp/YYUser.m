//
//  YYUser.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/15.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "YYUser.h"

@interface YYUser ()
@end
@implementation YYUser

id _user;

+(id)allocWithZone:(struct _NSZone *)zone{
    
    if (_user == nil) {
        _user = [super allocWithZone:zone];
    }
    return _user;
}

+(instancetype)shareUser{
    return [[self alloc]init];
}
-(void)makeWithDict:(NSDictionary*)dict{
    [self setValuesForKeysWithDictionary:dict];

}
-(void)makeWithNull{
    self.account = nil;
    self.id = nil;
    self.name = nil;
    self.password = nil;
    self.phone = nil;

}
+(void)exit{
    [[self shareUser] makeWithNull];
}


@end
