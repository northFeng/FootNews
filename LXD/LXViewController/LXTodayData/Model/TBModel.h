//
//  TBModel.h
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBModel : NSObject


/**  */
@property (nonatomic,copy) NSString *img;

/** <#title#> */
@property (nonatomic,copy) NSString *descriptionS;

/** <#title#> */
@property (nonatomic,copy) NSString *title;

/** <#title#> */
@property (nonatomic,copy) NSString *url;


@end


/**
 "img":"http://resource.ttplus.cn/publish/app/special/2018/06/27/4849dc8f-2e81-4b93-afbd-65f6aaf4ef67.jpg@!img01",
 "description":"体坛俄罗斯日记：记录体坛在俄罗斯前方的故事",
 "id":69,
 "title":"体坛俄罗斯日记",
 "url":"http://resource.ttplus.cn/publish/app/special/2018/06/27/161851/special_area2_share.html"
 */
