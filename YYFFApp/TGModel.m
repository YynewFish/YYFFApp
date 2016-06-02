//
//  TGModel.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/20.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "TGModel.h"
#import "searchModel.h"

@implementation TGModel

static id _TGArray;

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
    return _TGArray;
}

-(instancetype)initTGWithModel:(searchModel*)mod{
    self = [super init];
    if (self) {
        self.id = mod.id;
        self.name = mod.name;
        self.city = mod.city;
        self.describe = mod.describe;
        self.address = mod.address;
        self.imageUrl = mod.imageUrl;
        self.type = mod.type;
    }
    return self;
    

}


+(instancetype)shareTGsWithArray:(NSArray*)array{
    
    NSMutableArray *TGs = [[NSMutableArray alloc] init];
    for (searchModel * mod in array) {
        TGModel * yy = [[TGModel alloc]initTGWithModel:mod];
        [TGs addObject:yy];
    }
    
    _TGArray = TGs;
    return _TGArray;
}














@end
