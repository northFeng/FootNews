//
//  APPHttpTool.m
//  GFAPP
//
//  Created by gaoyafeng on 2018/5/21.
//  Copyright © 2018年 North_feng. All rights reserved.
//

#import "APPHttpTool.h"


#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "AFNetworking.h"

@implementation APPHttpTool

+ (instancetype)sharedNetworking{
    
    static APPHttpTool *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[APPHttpTool alloc] init];
    });
    return handler;
}

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success fail:(Failure)fail{
    
    //NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
    
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFManager];
    
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"请求结果=%@",responseObject);
        
        if (success) {
            //NSInteger code = [responseObject[@"result_code"] integerValue];
            
            if (responseObject){
                success(responseObject,0);
            } else {
                if (fail) {
                    fail(nil);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)getWithUrlTwo:(NSString *)url params:(NSDictionary *)params success:(Success)success fail:(Failure)fail{
    
    //NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
    
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFManager];
    
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"请求结果=%@",responseObject);
        
        if (success) {
            success(responseObject,0);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        
        if (fail) {
            fail(error);
        }
    }];
}






+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success fail:(Failure)fail
{
    NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
    
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果=%@",responseObject);
        
        if (success) {
            
            //NSInteger code = (NSInteger)responseObject[@"message"][@"code"];
            NSInteger code = [responseObject[@"status_code"] integerValue];
            
            if (code == 200){
                
                success(responseObject,code);
            } else {
                if (fail) {
                    fail(nil);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)deleteWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success fail:(Failure)fail
{
    
    NSLog(@"请求地址----%@\n    请求参数----%@",url,params);
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    [manager DELETE:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果=%@",responseObject);
        if (success) {
            NSInteger code = (NSInteger)responseObject[@"message"][@"code"];
            
            
            if (code==401||code==403||code==-10001)
            {
                
                if (fail) {
                    fail(nil);
                }
            }
            else {
                success(responseObject,code);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
    }];
}


#pragma makr - 开始监听网络连接
+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status){
                
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                [APPHttpTool sharedNetworking].networkStats=StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                [APPHttpTool sharedNetworking].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [APPHttpTool sharedNetworking].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [APPHttpTool sharedNetworking].networkStats=StatusReachableViaWiFi;
                NSLog(@"WIFI--%d",[APPHttpTool sharedNetworking].networkStats);
                break;
        }
        
    }];
}

#pragma mark - 创建AFN管理者
+(AFHTTPSessionManager *)getAFManager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求序列化
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 15;
    
    //响应序列化
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    //响应数据格式设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    return manager;
    
}

+(NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
