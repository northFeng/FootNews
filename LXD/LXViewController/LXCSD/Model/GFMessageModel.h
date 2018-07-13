//
//  GFMessageModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/13.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFMessageModel : NSObject


/** 标题 */
@property (nonatomic,copy) NSString *info_title;

/** 副标题 */
@property (nonatomic,copy) NSString *info_desc;

/** 来源 */
@property (nonatomic,copy) NSString *info_src;

/** 阅读量 */
@property (nonatomic,copy) NSString *comment_num;

/** 时间 */
@property (nonatomic,copy) NSString *info_time;

/** url */
@property (nonatomic,copy) NSString *info_url;


@end

/**
"comment_num":111,
"crt_time":1464049532000,
"info_desc":"<span>本场是迪比亚、阿奇·汤普森最后一次为胜利上场。</span>",
"info_id":"155438",
"info_league_name":"亚洲联赛冠军杯",
"info_pic":"",
"info_src":"亚冠官网",
"info_time":"2016-05-24 08:25:32",
"info_title":"亚冠 18:00 全北现代VS墨尔本胜利﻿﻿",
"info_type":1,
"info_type_name":"情报",
"info_url":"http://www.buyinball.com/html/caa672d7fbc34d90a749b7a96dfda20c.html",
"is_favorite":0,
"is_top":0
 
 */

