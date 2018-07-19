//
//  VideoModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/18.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

/** pid */
@property (nonatomic,copy) NSString *pid;

/** title */
@property (nonatomic,copy) NSString *title;

/**  */
@property (nonatomic,copy) NSString *shorttitle;

/** authorName */
@property (nonatomic,copy) NSString *authorName;

/** imgurl */
@property (nonatomic,copy) NSString *imgurl;

/** videourl */
@property (nonatomic,copy) NSString *videourl;

/**  */
@property (nonatomic,copy) NSString *videodesc;

/** 作者头像 */
@property (nonatomic,copy) NSString *authorHeadImage;

/** 关键词 */
@property (nonatomic,copy) NSString *keywords;

/** 总结 */
@property (nonatomic,copy) NSString *summary;

/** <#title#> */
@property (nonatomic,copy) NSString *searchcontent;


@end

/**
 
 "keywords":"2018世界杯,法国队,英格兰队,坎通纳,姆巴佩",
 "columns":"国际足球",
 "day_date_order":1531843200019,
 "authorHeadImage":"http://resource.ttplus.cn/editor/headphoto/a83a42a3-abd5-4dc0-9580-2406e507bd95.jpg",
 "pid":143856,
 "source":"体坛Plus",
 "title":"坎通纳吐槽大会：足球回家，回了德尚的家…",
 "type":5,
 "is_best":0,
 "imgurl":"http://resource.ttplus.cn/publish/app/video/2018/07/18/166878/a2a13fde-aede-4a6e-8966-5fab49abe98f.jpg@!img01",
 "newstime":1531883739424,
 "authorAuthentication":1,
 "id":166878,
 "shareurl":"http://resource.ttplus.cn/publish/app/video/2018/07/18/166878/video.html",
 "detailurl":"http://resource.ttplus.cn/publish/app/video/2018/07/18/166878/detail.json",
 "keyword":"2018世界杯,法国队,英格兰队,坎通纳,姆巴佩",
 "imgType":0,
 "commentnum":2,
 "summary":"“2014德国，2018法国。足球没有回家，但已经越来越近了。”",
 "thumbnail":"http://resource.ttplus.cn/publish/app/video/2018/07/18/166878/thumbnail/a2a13fde-aede-4a6e-8966-5fab49abe98f.jpg@!img01",
 "shorttitle":"坎通纳吐槽大会：足球回德尚的家…",
 "superVideourl":"http://vod.ttplus.cn/product/act-ss-m3u8-hd/03ab0d1890004db98f3f09a8f7fc96e4/video_news_166878.m3u8",
 "searchcontent":"坎通纳吐槽大会：足球回家，回了德尚的家…,朱斯蒂,2018世界杯,法国队,英格兰队,坎通纳,姆巴佩,国际足球,,“2014德国，2018法国。足球没有回家，但已经越来越近了。”",
 "authorDescription":"体坛+国际足球撰稿人",
 "label":"视频",
 "authorId":"d38414fb-d517-472d-a0a1-5b0c2d7c777d",
 "likenum":1,
 "standardVideourl":"http://vod.ttplus.cn/product/act-ss-m3u8-sd/03ab0d1890004db98f3f09a8f7fc96e4/video_news_166878.m3u8",
 "hot_value":1817.9779499999997,
 "pcVideourl":"http://vod.ttplus.cn/product/act-ss-m3u8-hd/03ab0d1890004db98f3f09a8f7fc96e4/video_news_166878.m3u8",
 "videourl":"http://vod.ttplus.cn/product/act-ss-m3u8-sd/03ab0d1890004db98f3f09a8f7fc96e4/video_news_166878.m3u8",
 "authorSubscribe":1,
 "videodesc":"“法国和比利时赛后，我儿子跑到园子里模仿姆巴佩的脚后跟动作。我突然意识到，此刻全世界有成千上万的孩子都在做着同样的事情。就在这时候，我知道我对足球的爱永远不会死去。”",
 "best_order":0,
 "authorName":"朱斯蒂",
 "imgList":[
 
 ]
 */
