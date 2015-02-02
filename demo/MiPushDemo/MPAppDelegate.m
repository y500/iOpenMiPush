//
//  MPAppDelegate.m
//  MiPushDemo
//
//  Created by shen yang on 14-3-6.
//  Copyright (c) 2014年 Xiaomi. All rights reserved.
//

#import "MPAppDelegate.h"
#import "MPViewController.h"

@implementation MPAppDelegate
{
    MPViewController *vMain;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    vMain = [[MPViewController alloc] init];
    self.window.rootViewController = vMain;
    [self.window makeKeyAndVisible];

    [MiPushSDK registerMiPush:self];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark 注册push服务.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [vMain printLog:[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]];

    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    [vMain printLog:[NSString stringWithFormat:@"APNS error: %@", err]];

    // 注册APNS失败.
    // 自行处理.
}

#pragma mark Local And Push Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [vMain printLog:[NSString stringWithFormat:@"remote notify %@", userInfo]];

    NSString *messageId = [userInfo objectForKey:@"miid"];
    [MiPushSDK openAppNotify:messageId];
}

#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    [vMain printLog:[NSString stringWithFormat:@"succ(%@): %@", [self getOperateType:selector], data]];
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    [vMain printLog:[NSString stringWithFormat:@"error(%d|%@): %@", error, [self getOperateType:selector], data]];
}

- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector isEqualToString:@"registerMiPush:"]) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }

    return ret;
}


@end