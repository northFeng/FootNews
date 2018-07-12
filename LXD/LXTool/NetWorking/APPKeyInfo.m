//
//  APPKeyInfo.m
//  GFAPP
//
//  Created by gaoyafeng on 2018/5/10.
//  Copyright © 2018年 North_feng. All rights reserved.
//

#import "APPKeyInfo.h"


#pragma mark - 主机URL
///测试服务器http://47.93.174.41:8100
static NSString *const debugHostUrl = @"http://www.buyinball.com/app-web/api/";

///release服务器                          
static NSString *const releaseHostUrl = @"http://www.buyinball.com/app-web/api/";


#pragma mark - key设置
///APPId
static NSString *const APPId = @"1111111111";

static NSString *jgAPPKey = @"b2ab418b562578cc57c4590f";

static NSString *jgMasterSecret = @"e9f50422ad08f9f9765fcf50";


@implementation APPKeyInfo

///获取APPID
+ (NSString *)getAppId{
    return APPId;
}

///主机域名
+ (NSString *)hostURL{
    NSString *hostUrl;
    
#if DEBUG
    hostUrl = debugHostUrl;
#else
    hostUrl = releaseHostUrl;
#endif
 
    return hostUrl;
}

+ (NSString *)getJGAppKey{
    NSString *jgAppKey = jgAPPKey;
    return jgAppKey;
}

+ (NSString *)getJGMasterSecret{
    NSString *jgMS = jgMasterSecret;
    return jgMS;
}




@end
