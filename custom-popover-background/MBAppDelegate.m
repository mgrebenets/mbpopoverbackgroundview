//
//  MBAppDelegate.m
//  custom-popover-background
//
//  Created by Grebenets Maksym on 8/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MBAppDelegate.h"
#import "MBPopoverBackgroundView.h"
#import "MBPopoverBackgroundViewRed.h"
#import "MBPopoverBackgroundViewGreen.h"
#import "MBPopoverBackgroundViewBlue.h"

@implementation MBAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // block this line, it overrides window loaded from storyboard
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // set navigation bar appearance
    [[UINavigationBar appearance] setTintColor: [UIColor colorWithRed:0.481 green:0.065 blue:0.081 alpha:1.000]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    
    // set appearances for popovers
    [MBPopoverBackgroundView initialize];
    
    // red with arrow
    [MBPopoverBackgroundViewRed setArrowImageName:@"popover-arrow-red.png"];
    [MBPopoverBackgroundViewRed setBackgroundImageName:@"popover-background-red.png"];
    [MBPopoverBackgroundViewRed setBackgroundImageCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [MBPopoverBackgroundViewRed setContentViewInsets:UIEdgeInsetsMake(10, 10, 10, 10)]; 
    
    // green with blue pin
    [MBPopoverBackgroundViewGreen setArrowImageName:@"popover-pin-blue.png"];
    [MBPopoverBackgroundViewGreen setBackgroundImageName:@"popover-background-green.png"];
    [MBPopoverBackgroundViewGreen setBackgroundImageCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [MBPopoverBackgroundViewGreen setContentViewInsets:UIEdgeInsetsMake(30, 20, 20, 10)]; 

    // blue with dottet callour
    [MBPopoverBackgroundViewBlue setArrowImageName:@"popover-callout-dotted-blue.png"];
    [MBPopoverBackgroundViewBlue setBackgroundImageName:@"popover-background-blue.png"];
    [MBPopoverBackgroundViewBlue setBackgroundImageCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [MBPopoverBackgroundViewBlue setContentViewInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    [MBPopoverBackgroundView cleanup];
}

@end
