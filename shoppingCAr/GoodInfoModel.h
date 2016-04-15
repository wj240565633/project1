//
//  GoodInfoModel.h
//  shoppingCAr
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodInfoModel : NSObject
@property(nonatomic,retain)NSString * imageName;
@property(nonatomic,retain)NSString * goodsTitle;
@property(nonatomic,retain)NSString * goodsPrice;
@property(nonatomic,assign)BOOL selectState;
@property(nonatomic,assign)int goodsNum;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
