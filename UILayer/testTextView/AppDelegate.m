//
//  AppDelegate.m
//  testTextView
//
//  Created by ml  on 16/11/1.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "AppDelegate.h"
#import "DEMOLeftMenuViewController.h"
#import "ReadTrainTableViewController.h"
#import "ToolCommon.h"
@interface AppDelegate (){
    UIViewController* _rootViewController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //g_dwGLogZoneSeed = tAll_MSK;
    
    _rootViewController=[[ReadTrainTableViewController alloc]initWithStyle:UITableViewStylePlain];
    // 加入侧滑功能
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];//去掉右边滑动
    //sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
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




#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    //GLog(tOther,(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class])));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    //GLog(tOther,(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class])));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    //GLog(tOther,(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class])));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    //GLog(tOther,(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class])));
}
@end
