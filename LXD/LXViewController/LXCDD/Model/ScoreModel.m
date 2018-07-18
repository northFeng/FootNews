//
//  ScoreModel.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "ScoreModel.h"

@implementation ScoreModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
              @"team" : @"team[0].title",
              @"file" : @"file[0].path"
             };
}

@end
