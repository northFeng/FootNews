//
//  ScoreModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreModel : NSObject

//上部
/** 标题 */
@property (nonatomic,copy) NSString *league_name;

/** 时间 */
@property (nonatomic,copy) NSString *match_time;

/** 颜色 */
@property (nonatomic,copy) NSString *league_color;

//中部

/** 黄色数字 */
@property (nonatomic,copy) NSString *h_yellow;

/** 中括号 */
@property (nonatomic,copy) NSString *home_team_rank;

/** 左边队名 */
@property (nonatomic,copy) NSString *home_team_name;

/** 比分 */
@property (nonatomic,copy) NSString *home_team_score;


/** 右边黄色数字 */
@property (nonatomic,copy) NSString *g_yellow;

/** 中括号数字 */
@property (nonatomic,copy) NSString *guest_team_rank;

/** 队名 */
@property (nonatomic,copy) NSString *guest_team_name;

/** 比分 */
@property (nonatomic,copy) NSString *guest_team_score;


//下部
/** 左边 */
@property (nonatomic,copy) NSString *asian_odds;

/** 右边 */
@property (nonatomic,copy) NSString *europe_odds;

/** 评论数 */
@property (nonatomic,copy) NSString *comment_num;




@end

/**
 
 //底部
"asian_odds":"1.16,-0/0.5,0.72",--1
 
"cap_type_name":"平半",
 
"comment_num":80,--3

"europe_odds":"2.31,3.95,2.42",--2
 
 
 //右边
"g_yellow":"2",-4
"guest_red_card":"0",
"guest_team_first_score":"0",
"guest_team_id":"21339",
"guest_team_name":"比尔利克",//队名-2
"guest_team_rank":"8",//-3
"guest_team_score":"0",//得分-1
 
 //左边
"h_yellow":"3",-4
"home_red_card":"0",
"home_team_first_score":"0",
"home_team_id":"13542",
"home_team_logo":"http://www.buyinball.com/img/74fc224b64e0451fb453f9f9b3243f27.jpeg",
"home_team_name":"阿西里斯卡BK",-2
"home_team_rank":"10",-3
"home_team_score":"2",-1
 
 
"is_analysis":0,
"is_bet":1,
"is_live":1,
"is_top":0,
"is_video":1,
"league_color":"#e8811a",
 
 //上
"league_name":"瑞典丙",--1
 
"mark_analy":0,
"match_id":"201807070001436000216078",
 
 
"match_time":"2018-07-07 19:30:00",--2
"running_time":4572,
"status_cd":4,
"update_time":1530969124277
 
 */
