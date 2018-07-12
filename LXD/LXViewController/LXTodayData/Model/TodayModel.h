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



@end


/**
{
    "cur_time": 1530953956603,
    "msg_code": "0",
    "qry_infos": {
        "banners": [{
            "info_id": "10000421061",
            "info_pic": "http://www.buyinball.com/img/a05a94e7c95d4d61892e54973e68d252.jpg",
            "info_title": "战报",
            "obj_type": 3
        }, {
            "info_id": "10000421166",
            "info_pic": "http://www.buyinball.com/img/c8524fe1b80d42df8a1617c439aa6e26.jpg",
            "info_title": "解盘",
            "obj_type": 3
        }, {
            "info_pic": "http://www.buyinball.com/img/ec286ba3b375472fab2361c5a26f90d0.jpg",
            "info_title": "红包雨7.6—7.9",
            "info_url": "https://www.buyinball.com/ny3G/game-act/cchb/index.html?appType=byty&from=groupmessage&isappinstalle",
            "obj_type": 2
        }, {
            "info_id": "10000420989",
            "info_pic": "http://www.buyinball.com/img/552c6bfd560d4f13818fde48cd9bd130.jpg",
            "info_title": "尤文图斯求购C罗",
            "obj_type": 3
        }, {
            "info_id": "10000420542",
            "info_pic": "http://www.buyinball.com/img/553661c18cb84411877f345a4da66eaa.jpg",
            "info_title": "盘路",
            "obj_type": 3
        }],
        "data": [{
            "comment_num": 394,
            "crt_time": 1464069321000,
            "info_id": "155897",
            "info_league_name": "",
            "info_pic": "http://www.buyinball.com/img/a3b842fd91d14417a3799209f06638e9_206x130.jpg",
            "info_src": "",
            "info_time": "2016-05-24 13:55:21",
            "info_title": "媒体名家面对面第五期叶慧：深刻洞悉战意是竞猜盈利的关键法宝",
            "info_type": 0,
            "info_type_name": "头条",
            "info_url": "http://www.buyinball.com/html/58f09d9ba43444788ac52e643239f659.html",
            "is_favorite": 0,
            "is_top": 1
        }, {
            "comment_num": 448,
            "crt_time": 1464134466000,
            "info_id": "156374",
            "info_league_name": "",
            "info_pic": "http://www.buyinball.com/img/e0da494f9da840ad8069142ef31f3b3b_206x130.jpg",
            "info_src": "",
            "info_time": "2016-05-25 08:01:06",
            "info_title": "有奖猜球5月24日战报：“纵横四海”再中大奖进一步巩固领先优势",
            "info_type": 0,
            "info_type_name": "头条",
            "info_url": "http://www.buyinball.com/html/203fbcc681be422a81992bddf19dcffa.html",
            "is_favorite": 0,
            "is_top": 1
        }, {
            "comment_num": 407,
            "crt_time": 1464146855000,
            "info_id": "156656",
            "info_league_name": "",
            "info_pic": "http://www.buyinball.com/img/2ba220874a524dbd9c4e268f59fecda9_206x130.jpg",
            "info_src": "",
            "info_time": "2016-05-25 11:27:35",
            "info_title": "推荐市场5月24日战报：“信阳茶都”领衔12名专家获100%胜率",
            "info_type": 10,
            "info_type_name": "推荐",
            "info_url": "http://www.buyinball.com/html/674610c0584246f7b9f44682fc6ebb9e.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 182,
            "crt_time": 1464143155000,
            "info_id": "156557",
            "info_league_name": "",
            "info_pic": "http://www.buyinball.com/img/42a5d0a9a0f8497f8921f952e9e0295e_206x130.jpg",
            "info_src": "",
            "info_time": "2016-05-25 10:25:55",
            "info_title": " 亚冠-悉尼VS鲁能前瞻：鲁能最强阵战悉尼 自信客场灭对手晋级",
            "info_type": 8,
            "info_type_name": "中超",
            "info_url": "http://www.buyinball.com/html/6cb493f9c2b54225b62de0eadd80beb7.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 264,
            "crt_time": 1464143008000,
            "info_id": "156542",
            "info_league_name": "欧洲联赛冠军杯赛",
            "info_pic": "http://www.buyinball.com/img/b0a6f847449d41a6a58745beb7f115aa_206x130.jpg",
            "info_src": "新浪体育",
            "info_time": "2016-05-25 10:23:28",
            "info_title": "欧冠-C罗欧冠决赛破门即成第1人 金球压梅西在此一举",
            "info_type": 7,
            "info_type_name": "国际",
            "info_url": "http://www.buyinball.com/html/4c1b9f617d614a3585f92894c56d3103.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 131,
            "crt_time": 1464134867000,
            "info_id": "156386",
            "info_league_name": "中国超级联赛",
            "info_pic": "http://www.buyinball.com/img/2819d5e80fbc49c3858ac8c86ec4f132_206x130.jpg",
            "info_src": "腾讯体育",
            "info_time": "2016-05-25 08:07:47",
            "info_title": "埃帅不满足于亚冠八强 二次报名吉安或被调整",
            "info_type": 8,
            "info_type_name": "中超",
            "info_url": "http://www.buyinball.com/html/ca0c358d90e94a059edfb2a9cae8e3c6.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 69,
            "crt_time": 1464131563000,
            "info_id": "156350",
            "info_league_name": "中国超级联赛",
            "info_pic": "http://www.buyinball.com/img/63e7e71dad884d0e9dd1795f6864d7f6_206x130.jpg",
            "info_src": "腾讯体育",
            "info_time": "2016-05-25 07:12:43",
            "info_title": "亚冠-两队8强?创历史只等鲁能 今晚中国球迷都挺你",
            "info_type": 8,
            "info_type_name": "中超",
            "info_url": "http://www.buyinball.com/html/db030b69a1154d3fa677ebdffc8752ef.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 73,
            "crt_time": 1464124779000,
            "info_id": "156323",
            "info_league_name": "法国甲组联赛",
            "info_pic": "http://www.buyinball.com/img/0612a2954a4249febddf2971dd8ed60a_206x130.jpg",
            "info_src": "新浪体育",
            "info_time": "2016-05-25 05:19:39",
            "info_title": "法国队宣布瓦拉内无缘欧洲杯 塞维利亚铁卫登场",
            "info_type": 7,
            "info_type_name": "国际",
            "info_url": "http://www.buyinball.com/html/80f1383fac6b4d2ea7ea48a831c28f87.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 161,
            "crt_time": 1464086622000,
            "info_desc": "上港周末中超轮换，有备而战，竞彩赔率一致看好，赢球概率高达81%",
            "info_id": "156107",
            "info_league_name": "",
            "info_pic": "http://www.buyinball.com/img/ff5e95e57e7246cb88962c9b856a01b4_206x130.jpg",
            "info_src": "",
            "info_time": "2016-05-24 18:43:42",
            "info_title": "亚冠-上港VS东京首发：孙祥先发埃神箭头 吉安继续缺阵",
            "info_type": 8,
            "info_type_name": "中超",
            "info_url": "http://www.buyinball.com/html/7f372f6448964185884d634b437ef5b2.html",
            "is_favorite": 0,
            "is_top": 0
        }, {
            "comment_num": 57,
            "crt_time": 1464082457000,
            "info_id": "156083",
            "info_league_name": "意大利甲组联赛",
            "info_pic": "http://www.buyinball.com/img/baa1058ca489488d8dde6c4919b68349_206x130.jpg",
            "info_src": "新浪体育",
            "info_time": "2016-05-24 17:34:17",
            "info_title": "AC米兰官方宣布续约三大将 队长+飞翼签至2019年",
            "info_type": 7,
            "info_type_name": "国际",
            "info_url": "http://www.buyinball.com/html/1e4fef7394a1483a95b7199dc5034e42.html",
            "is_favorite": 0,
            "is_top": 0
        }],
        "page_index": "11"
    },
    "result_code": "0",
    "result_msg": "成功"
}
 
 */












