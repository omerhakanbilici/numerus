//
//  AppDelegate.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 7.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "AppDelegate.h"
#import <BugSense-iOS/BugSenseController.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Changing the Font of Navigation Bar Title
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1.0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor blackColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:33.0], NSFontAttributeName, nil]];
    // Color of Back button white
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // Changing the Style of Status Bar Default
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // initialize defaults
    NSString *score = @"HighScore";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *highScore = (NSNumber *)[prefs objectForKey:score];
    
    if (highScore == nil) {
        // sync the defaults to disk
        [[NSUserDefaults standardUserDefaults] setInteger:1043 forKey:score];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //BugSense
    [BugSenseController sharedControllerWithBugSenseAPIKey:@"2a57c707"];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
