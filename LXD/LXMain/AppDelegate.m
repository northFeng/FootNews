//
//  AppDelegate.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "AppDelegate.h"

//输入跟踪日志框架
#import "Aspects.h"

#import "GFNavigationController.h"

#import "GFTabBarController.h"

#import "TodayViewController.h"
#import "CDDViewController.h"
#import "CSDViewController.h"


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

/**  */
@property (nonatomic,assign) BOOL isAction;

@end

@implementation AppDelegate

///获取后天的URL
- (void)getNetUrl{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.78.83.23/index.php?app_id=com.northfeng.footNews"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    
    APPWeakSelf
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *dic;
            if (data) {
                dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
            if (dic) {
                NSArray *array = dic[@"url"];
                NSString *url;
                if (array.count) {
                    url = array[0];
                }
                if (url.length) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //加载webVC
                        [weakSelf loadWebViewController:url];
                        //mainWindow.rootViewController = navi;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [weakSelf setRootViewController];//设置根视图
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf setRootViewController];//设置根视图
                });
            }
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setRootViewController];//设置根视图
            });
        }
    }];
    
    [dataTask resume];
}

///
- (void)loadWebViewController:(NSString *)htmlUrl{
    
    WebUrlViewController *webVC = [[WebUrlViewController alloc] init];
    webVC.htmlUrl = htmlUrl;
    
    //UIWindow *mainWindow = ([UIApplication sharedApplication].delegate).window;
    
    GFNavigationController *navi = [[GFNavigationController alloc] initWithRootViewController:webVC];
    navi.navigationBar.hidden = YES;//隐藏系统导航条（只是隐藏的NavigationController上的naviBar，因此返回手势存在）
    //设置根视图
    self.window.rootViewController = navi;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _isAction = NO;
    
    // 如果 launchOptions 不为空
    if (launchOptions) {
        // 获取推送通知定义的userinfo
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (userInfo[@"url"]) {
            //APP死掉后点击通知栏，获取远程推送内容
            [self loadWebViewController:userInfo[@"url"]];
        }else{
            //设置根视图
            [self getNetUrl];
            //[self setRootViewController];
        }
    }else{
        //设置根视图
        [self getNetUrl];
        //[self setRootViewController];
    }
    
    [self analyticsViewController];//跟踪界面
    
    //设置极光推送
    [self setJPush:launchOptions];
    
    return YES;
}


#pragma mark - 添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support（当APP处于前台活跃，并未杀死时，推送过来会直接触发这个方法！！！！，通知栏也会通知弹框出来，但是通知弹框不会触发这个方法，而是会触发下面那个方法！至于这个处理看需求，正常APP推送消息过来不会不经过用户点击自动触发的！）
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    //自己处理推送消息
    NSString *htmlUrl = userInfo[@"url"];
    [self handleNotificationData:htmlUrl];
    
    //不弹出通知栏，直接跳进去
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置(这里其实是系统帮我们把 远程推送 ————> 转换 成 本地推送 弹框给用户看的)
}

// iOS 10 Support（app死亡或者不管APP处于前台还是后台，只要是点击通知栏的通知弹框，就会触发这个方法！！因此必须在这里进行推送消息的处理！！！）
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    //自己处理推送消息
    NSString *htmlUrl = userInfo[@"url"];
    [self handleNotificationData:htmlUrl];
    
    
    completionHandler();  // 系统要求执行这个方法
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required,For systems with less than or equal to iOS7
    [JPUSHService handleRemoteNotification:userInfo];

    //处理推送信息
    NSString *htmlUrl = userInfo[@"url"];
    [self handleNotificationData:htmlUrl];
    
    completionHandler(UIBackgroundFetchResultNewData);
     
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    //处理推送信息
    NSString *htmlUrl = userInfo[@"url"];
    [self handleNotificationData:htmlUrl];
}


#pragma mark - 处理推送消息
- (void)handleNotificationData:(NSString *)htmlUrl{
    
    //清空角标数量
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if (htmlUrl.length) {
        WebUrlViewController *webVC = [[WebUrlViewController alloc] init];
        webVC.htmlUrl = htmlUrl;
        
        UIWindow *mainWindow = ([UIApplication sharedApplication].delegate).window;
        GFNavigationController *navi = (GFNavigationController *)mainWindow.rootViewController;
        [navi presentViewController:webVC animated:YES completion:nil];
    }
}




///设置根视图
- (void)setRootViewController{
    
    TodayViewController *todayVC = [[TodayViewController alloc] init];
    CDDViewController *cddVC = [[CDDViewController alloc] init];
    CSDViewController *csdVC = [[CSDViewController alloc] init];
    
    GFTabBarController *gfTabBar = [GFTabBarController sharedInstance];
    gfTabBar.viewControllers = @[todayVC,cddVC,csdVC];//添加子视图
    //默认图片
    NSArray *arrayNomal = @[@"today_normal",@"foot_normal",@"basket_1_normal"];
    //选中按钮的图片
    NSArray *arraySelect = @[@"today_select",@"foot",@"basket_1"];
    //item的标题
    NSArray *arrayTitle = @[@"头条",@"比分",@"球星"];
    
    [gfTabBar creatItemsWithDefaultIndex:0 normalImageNameArray:arrayNomal selectImageArray:arraySelect itemsTitleArray:arrayTitle];//设置items并设置第一个显示位置
    
    
    GFNavigationController *navi = [[GFNavigationController alloc] initWithRootViewController:gfTabBar];
    navi.navigationBar.hidden = YES;//隐藏系统导航条（只是隐藏的NavigationController上的naviBar，因此返回手势存在）
    //设置根视图
    self.window.rootViewController = navi;
    
}

- (void)analyticsViewController {
    //放到异步线程去执行
    //__weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Aspect only debug
        //面向切面，用于界面日志的输出
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:0 usingBlock:^(id<AspectInfo> info){
            NSLog(@"ViewContriller Enter \n ==================> \n %@", info.instance);
        } error:NULL];
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:0 usingBlock:^(id<AspectInfo> info){
            NSLog(@"ViewContriller Exit \n ==================> \n %@", info.instance);
        } error:NULL];
        [UIViewController aspect_hookSelector:@selector(didReceiveMemoryWarning) withOptions:0 usingBlock:^(id<AspectInfo> info){
            NSLog(@"ViewContriller didReceiveMemoryWarning \n ==================> \n %@", info.instance);
        } error:NULL];
    });
}



#pragma mark - 开启极光
- (void)setJPush:(NSDictionary *)launchOptions{
    
    //配置极光推送
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    
    BOOL isProduction;
#if DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    [JPUSHService setupWithOption:launchOptions appKey:[APPKeyInfo getJGAppKey]
                          channel:@"AppStore"
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    //清空角标数量
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

///注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
