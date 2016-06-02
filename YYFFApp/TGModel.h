//
//  TGModel.h
//  YYFFApp
//
//  Created by 余跃 on 16/5/20.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGModel : NSObject

@property int id;
@property NSString *name;
@property NSString *city;
@property NSString *describe;
@property NSString *address;
@property NSString *imageUrl;
@property NSString *type;
-(instancetype)initWithDict:(NSDictionary*)dict;
+(id)shareModelArray;
+(instancetype)shareTGsWithArray:(NSArray*)array;
@end
