//
//  AppDelegate.m
//  YYFFApp
//
//  Created by 余跃 on 16/5/7.
//  Copyright (c) 2016年 余跃. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController.h"
#import "YYMainViewController.h"
#import "YYSearchViewController.h"
#import "YYUsersViewController.h"
#import "searchModel.h"
#import "TGModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//+(int)yyGetusersId{
//    
//    return self.usersId;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    //UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:loginVc];
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabbarVc;
    //主页
    YYMainViewController *yymVc = [[YYMainViewController alloc] init];
    yymVc.title = @"首页";
    yymVc.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    //搜索
    YYSearchViewController *searchVc = [[YYSearchViewController alloc]init];
    searchVc.title = @"搜索";
    searchVc.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    //个人
    YYUsersViewController *userVc = [[YYUsersViewController alloc]init];
    userVc.title = @"我";
    userVc.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    

    [tabbarVc addChildViewController:[[UINavigationController alloc]initWithRootViewController:yymVc] ];
    [tabbarVc addChildViewController:[[UINavigationController alloc]initWithRootViewController:searchVc]];
    [tabbarVc addChildViewController:[[UINavigationController alloc]initWithRootViewController:userVc]];
    [self.window makeKeyAndVisible];
    
    [TGModel shareTGsWithArray:[searchModel searchWithWord:@"哈尔滨"]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
