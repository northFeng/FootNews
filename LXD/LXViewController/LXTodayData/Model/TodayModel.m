//
//  TodayModel.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/11.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TodayModel.h"

@implementation BannerModel




@end

@implementation ListModel




@end

@implementation TodayModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"banners" : [BannerModel class],
             @"data" : [ListModel class]
             };
}

    

@end
