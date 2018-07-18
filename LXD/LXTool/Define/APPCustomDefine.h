//
//  APPCustomDefine.h
//  GFAPP
//
//  Created by XinKun on 2017/11/10.
//  Copyright © 2017年 North_feng. All rights reserved.
//

/**
 *
 *  常量命名规则（驼峰式命名规则），所有的单词首字母大写和加上与类名有关的前缀:
 *
 */

#ifndef APPCustomDefine_h
#define APPCustomDefine_h


//.h
#define SingletonIterface(class) +(instancetype) shared##class;
// .m
#define SingletonImplementation(class)         \
static class *_instance;                        \
\
+(id) allocWithZone : (struct _NSZone *) zone { \
static dispatch_once_t onceToken;           \
dispatch_once(&onceToken, ^{                \
_instance = [super allocWithZone:zone]; \
});                                         \
\
return _instance;                           \
}                                               \
\
+(instancetype) shared##class                   \
{                                           \
if (_instance == nil) {                     \
_instance = [[class alloc] init];       \
}                                           \
\
return _instance;                            \
}



// iOS tableview 置顶
#define  KTableViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


#pragma mark - 常用自定义宏
//***********************************************
//**********      常用自定义宏      *************
//***********************************************

///weakSelf宏定义
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define APPWeakSelf __weak typeof(self) weakSelf = self;
#define APPStrongSelf __strong typeof(self) strongSelf = weakSelf;

//网络宏
#define HTTPURL(url) [NSString stringWithFormat:@"%@%@",[APPKeyInfo hostURL],url]

//空字符串处理
#define APPString(string) [string length] > 0 ? string : @"0"


//获取屏幕 宽度、高度 APP_SCREEN_WIDTH  APP_SCREEN_HEIGHT APP_StatusBar_Height
#define APP_SCREEN_BOUNDS   ([[UIScreen mainScreen] bounds])
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KSCALE kScreenWidth / 375.0
#define kScaleHeight(y,x,width) (y)/(x)*(width)
#define kScaleW kScreenWidth/375.0
#define kScaleH kScreenHeight/667.0

//顶部条以及tabBar条的宽度，以及工具条距离安全区域的距离
#define APP_NaviBarHeight (kStatusBarHeight > 20 ? 88. : 64.)
#define APP_NaviBar_ItemBarHeight 44.
#define APP_TabBarHeight (kStatusBarHeight > 20 ? 83. : 49.)
#define APP_TabBar_ItemsHeight 49.

#define kTopNaviBarHeight (kStatusBarHeight > 20 ? 88. : 64.)
#define kTabBarHeight (kStatusBarHeight > 20 ? 83. : 49.)


#pragma mark -- 颜色RGB宏定义
//***************************************
//        颜色RGB宏定义
//***************************************
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGBSA(r,a) [UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:(a)]

#define RGBS(r) [UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:1]

//rgb颜色转换（16进制->10进制）
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark - 图片加载宏
///url转换
#define kURLString(url) [NSURL URLWithString:url]
///赋值图片
#define kImgViewSetImage(imgView,url,placeholderName) [imgView sd_setImageWithURL:kURLString(url) placeholderImage:[UIImage imageNamed:placeholderName] options:(SDWebImageRetryFailed)];
///赋值GIF图片
#define kImgViewSetGifImage(imgView,gifName) imgView.image = [UIImage sd_animatedGIFWithData:[[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"]]];

#define GreenCoGlor RGB(20,207,36)



#endif /* APPCustomDefine_h */
