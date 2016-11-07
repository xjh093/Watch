//
//  AppDelegate.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //如果已经获得发送通知的授权则授权创建本地通知，否则请求授权
    //如果不请求授权在设置中是没有对应的通知设置项的，
    //也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone)
    {
        //添加通知
        //[self addLocalNotification];
        
        //接收通知参数
        UILocalNotification *notificaton = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        NSDictionary *userInfo = notificaton.userInfo;
        if (userInfo)
        {
            [userInfo writeToFile:@"/Users/lightech/Desktop/didFinishLaunchingWithOptions.txt" atomically:YES];
            NSLog(@"didFinishLaunchingWithOptions:The userInfo is %@.",userInfo);
        }
    }
    else
    {
        [[UIApplication sharedApplication]
            registerUserNotificationSettings:[UIUserNotificationSettings
            settingsForTypes:UIUserNotificationTypeAlert|
                             UIUserNotificationTypeBadge|
                             UIUserNotificationTypeSound
            categories:nil]];
    }
    
    return YES;
}

#pragma mark - 接收本地通知时触发
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    NSDictionary *userInfo = notification.userInfo;
//    if (userInfo)
//    {
//        [userInfo writeToFile:@"/Users/lightech/Desktop/didReceiveLocalNotification.txt" atomically:YES];
//        NSLog(@"didReceiveLocalNotification:The userInfo is %@",userInfo);
//    }
}

#pragma mark - 调用过用户注册通知方法之后执行(也就是调用完registerUserNotificationSettings:方法之后执行)
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types != UIUserNotificationTypeNone)
    {
        //[self addLocalNotification];
    }
}

#pragma mark - 进入前台后设置消息信息
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //进入前台取消应用消息图标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma mark - 私有方法
#pragma mark 添加本地通知
- (void)addLocalNotification
{
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    //设置调用时间
    //通知触发时间，10s以后
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
    
    //通知重复次数
    notification.repeatInterval = 2;
    
    //当前日历，使用前最好设置时区等信息以便能够自动同步时间
    //notification.repeatCalendar=[NSCalendar currentCalendar];
    
    //设置通知属性
    //通知主体
    notification.alertBody = @"最近添加了诸多有趣的特性，是否立即体验？";
    
    //应用程序图标右上角显示的消息数
    notification.applicationIconBadgeNumber = 1;
    
    //待机界面的滑动动作提示
    notification.alertAction = @"打开应用";
    
    //通过点击通知打开应用时的启动图片，这里使用程序启动图片
    notification.alertLaunchImage = @"Default";
    
    //收到通知时播放的声音，默认消息声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //通知声音(需要真机才能听到声音)
    //notification.soundName = @"msg.caf";
    
    //设置用户信息
    //绑定到通知上的其他附加信息
    notification.userInfo = @{@"id":@1,@"user":@"Haomissyou"};
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - 移除本地通知，在不需要此通知时刻移除
- (void)removeNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
