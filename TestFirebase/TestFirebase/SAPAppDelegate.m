//
//  AppDelegate.m
//  TestFirebase
//
//  Created by ASH on 1/3/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPAppDelegate.h"

#import <Firebase.h>

#import "SAPChaptersViewController.h"

#import "UIWindow+SAPExtensions.h"

@implementation SAPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    SAPChaptersViewController *controller = [SAPChaptersViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    
    [FIRApp configure];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
