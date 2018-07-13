//
//  TodayModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/6/11.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>


///banner广告
@interface BannerModel : NSObject

/** info_id */
@property (nonatomic,copy) NSString *info_id;

/** 图片URL */
@property (nonatomic,copy) NSString *info_pic;

/** htmlUrl */
@property (nonatomic,copy) NSString *htmlUrl;

/** 标题 */
@property (nonatomic,copy) NSString *info_title;

/** 类型 */
@property (nonatomic,copy) NSString *obj_type;


@end


///列表
@interface ListModel : NSObject

/** id */
@property (nonatomic,copy) NSString *info_id;

/** 类型 */
@property (nonatomic,copy) NSString *info_type;

/** icon */
@property (nonatomic,copy) NSString *info_pic;

/** 标题 */
@property (nonatomic,copy) NSString *info_title;

/** 类型名字 */
@property (nonatomic,copy) NSString *info_type_name;

/** 阅读量 */
@property (nonatomic,copy) NSString *comment_num;

/** 时间 */
@property (nonatomic,copy) NSString *info_time;

/** HTML */
@property (nonatomic,copy) NSString *info_url;

@end


@interface TodayModel : NSObject

/** banners */
@property (nonatomic,copy) NSArray *banners;

/** data */
@property (nonatomic,copy) NSArray *data;



/** ID */
@property (nonatomic,copy) NSString *ID;

/** htmlUrl */
@property (nonatomic,copy) NSString *url;

/** 介绍 */
@property (nonatomic,copy) NSString *content168;

/** 图片 */
@property (nonatomic,copy) NSString *imglink;

/** 标题 */
@property (nonatomic,copy) NSString *title;

/** 作者 */
@property (nonatomic,copy) NSString *author;

@end


/**
"_id":Object{...},
"ID":838042661,
"url":"http://api.football.app887.com/article.html?id=838042661",
"urls":"https://apifootball.app887.com/article.html?id=838042661",
"date":"2017-08-17 18:30:17",
"sourcename":"欧冠",
"content168":"虎扑8月17日讯 著名的足球评述员詹俊老师新赛季加盟PPTV聚力体育，将独家解说英超、欧冠和西甲等重要赛事。45岁的詹俊出生于广东省潮州市，1995年从中山大学毕业后进入了广东电视台体育部工作。1997年，詹俊第一次解说英超赛事，此后20年时间里，詹俊逐渐的被球迷所熟知和认可。除了英超联赛，詹俊还多次解说西甲、欧冠等赛事。此外，詹俊还",
"duration":"",
"imglink":"https://c1.hoopchina.com.cn/uploads/star/event/images/170817/6645f82a8d3a6929cb27085c593470cc9fe87e27.jpg",
"videolink":"",
"author":"虎扑足球",
"title":"zhei球进了！詹俊老师新赛季将在PPTV解说",
"titlespelling":"将在|进了|新赛季|老师|zhei",
"TYPE":"国际足球",
"SORT":0,
"PUBLISH":true,
"OPENSOURCE":true,
"DELFLAG":false,
"CTIME":"2017-08-17 18:30:17",
"TYPESETTING":0,
"readarts":1089,
"sharearts":29,
"talkcount":7,
"likecount":8,
"faved":0,
"liked":0,
"recommond":1,
"talks":Array[3]
*/










