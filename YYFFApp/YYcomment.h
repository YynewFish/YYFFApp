//
//  YYcomment.h
//  YYFFApp
//
//  Created by 余跃 on 16/5/20.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYcomment : NSObject

@property int id;
@property NSString *content;
@property NSString *username;
@property NSString *name;

+(void)shareCommentsWithName:(NSString*)name;
+(id)shareCommentArray;

@end
