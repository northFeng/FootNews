//
//  GFPersonModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/10.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFPersonModel : NSObject

/** 数列号 */
@property (nonatomic,copy) NSString *serial;

/** 球号 */
@property (nonatomic,copy) NSString *value;

/** 名字 */
@property (nonatomic,copy) NSString *playerName;

/** icon */
@property (nonatomic,copy) NSString *playerIcon;

/** web1 */
@property (nonatomic,copy) NSString *teamUrl;

/** web2 */
@property (nonatomic,copy) NSString *playerUrl;

@end

/**
 "serial":"1",
 "playerId":"4612",
 "playerUrl":"http://sports.qq.com/kbsweb/kbsshare/player.htm?ref=nbaapp&pid=4612",
 "playerName":"斯蒂芬-库里",
 "playerEnName":"Stephen Curry",
 "playerIcon":"https://nba.sports.qq.com/media/img/players/head/260x190/201939.png",
 "jerseyNum":"30",
 "teamId":"9",
 "teamUrl":"http://sports.qq.com/kbsweb/kbsshare/team.htm?ref=nbaapp&cid=100000&tid=9",
 "teamName":"勇士",
 "teamIcon":"http://mat1.gtimg.com/sports/nba/logo/black/9.png",
 "value":"37"
 
 */

/**
 http://sportsnba.qq.com/player/statsRank?statType=point&num=20&tabType=1&seasonId=2015&appver=1.0.2.2&appvid=1.0.2.2&network=wifi
 */
