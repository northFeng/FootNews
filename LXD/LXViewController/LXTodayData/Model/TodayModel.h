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


/** pid */
@property (nonatomic,copy) NSString *pid;

/** 标题 */
@property (nonatomic,copy) NSString *title;

/** 作者 */
@property (nonatomic,copy) NSString *authorName;

/** 图片 */
@property (nonatomic,copy) NSString *imgurl;

/** html */
@property (nonatomic,copy) NSString *shareurl;

/** 时间 */
@property (nonatomic,copy) NSString *newstime;

/**  */
@property (nonatomic,copy) NSArray *imgList;

@end

/**
"isoftop":1,
"columns":"国际足球",
"day_date_order":1531756800027,
"authorHeadImage":"http://resource.ttplus.cn/editor/headphoto/user_default.jpg",
"pid":143680,
"title":"法国队回国举行夺冠游行+造访爱丽舍宫",
"type":4,
"is_best":0,
"imgurl":"http://resource.ttplus.cn/publish/app/pics/2018/07/17/166673/69c8b4ff-e38b-44ca-9c65-ed5a34c1cb54.jpg@!img01",
"newstime":1531794334215,
"authorAuthentication":0,
"id":166673,
"shareurl":"http://resource.ttplus.cn/publish/app/pics/2018/07/17/166673/multi_pic.html",
"keyword":"2018世界杯,法国队",
"imgType":0,
"commentnum":0,
"thumbnail":"http://resource.ttplus.cn/publish/app/pics/2018/07/17/166673/thumbnail/69c8b4ff-e38b-44ca-9c65-ed5a34c1cb54.jpg@!img02",
"shorttitle":"法国队回国举行夺冠游行+造访爱丽舍宫",
"searchcontent":"法国队回国举行夺冠游行+造访爱丽舍宫,孙奇,2018世界杯,法国队,国际足球,",
"picnum":27,
"authorDescription":"",
"label":"图集",
"authorId":"d9f2cc1d-93e3-4342-b047-ed1b8559e096",
"likenum":0,
"hot_value":1956.05,
"authorSubscribe":0,
"best_order":0,
"authorName":"孙奇",
"picsList":"http://resource.ttplus.cn/publish/app/pics/2018/07/17/166673/picsList.json",
 */








