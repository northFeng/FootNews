//
//  TBModel.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TBModel.h"

@implementation TBModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             //@"imgurl" : @[@"imgurl",@"authorHeadImage"],
             @"descriptionS" : @[@"description"]
             };
}

@end
