//
//  GoodInfoModel.m
//  shoppingCAr
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GoodInfoModel.h"

@implementation GoodInfoModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.imageName = dict[@"imageName"];
        self.goodsTitle = dict[@"goodsTitle"];
        self.goodsPrice = dict[@"goodsPrice"];
        self.goodsNum = [dict[@"googNum"]intValue];
        self.selectState = [dict[@"selectState"]boolValue];
        
    }
    return self;
    
}
@end
