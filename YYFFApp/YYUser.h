//
//  YYUser.h
//  YYFFApp
//
//  Created by 余跃 on 16/5/15.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYUser : NSObject
@property int id;
@property NSString *account;
@property NSString *password;
@property NSString *name;
@property NSString *phone;
-(void)makeWithDict:(NSDictionary*)dict;
+(instancetype)shareUser;
+(void)exit;
@end
