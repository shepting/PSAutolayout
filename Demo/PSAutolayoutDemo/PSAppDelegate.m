//
//  PSAppDelegate.m
//  PSAutolayoutDemo
//
//  Created by Steven Hepting on 11/9/13.
//  Copyright (c) 2013 Hepting. All rights reserved.
//

#import "PSAppDelegate.h"
#import "PSKeyboardDemoViewController.h"
#import "PSMasterViewController.h"
#import "DCIntrospect.h"

@implementation PSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PSMasterViewController *master = [[PSMasterViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:master];
#if TARGET_IPHONE_SIMULATOR
    // Visual debugging tool for simulator
    [[DCIntrospect sharedIntrospector] start];
#endif
    [self.window setRootViewController:nav];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
