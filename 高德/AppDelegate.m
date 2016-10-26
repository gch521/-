//
//  AppDelegate.m
//  高德
//
//  Created by gch on 16/10/26.
//  Copyright © 2016年 gch. All rights reserved.
//
/*

 高德地图周边搜索:
 首先:使用 CocoaPods 安装 SDK
 编辑 Podfile 文件，并保存。 Podfile文件如下：
 
 platform :ios, '6.0' #手机的系统
 target 'YourProjectTarget' do
 pod 'AMap3DMap'  #3D地图SDK
 #pod 'AMap2DMap' #2D地图SDK (2D和3D不能同时使⽤用)
 pod 'AMapSearch' #搜索服务SDK
 end 
 运行 pod install 命令安装SDK
 更新安装的SDK pod repo update
 
 配置plist文件
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 
 iOS8以后定位需要在info.plist添加以下字段
 NSLocationWhenInUseUsageDescription 在应用使用期间访问用户位置 类型为String，后面文字没什么用可以不写（第一次定位弹出提示框上面显示的文字）
 完后就可以上官网下载:AMapFoundationKit.framework了, 导入工程, 就可以写了
 

*/

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
    return YES;
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
