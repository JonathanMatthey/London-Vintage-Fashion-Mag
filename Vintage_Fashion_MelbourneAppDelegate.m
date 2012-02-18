//
//  Vintage_Fashion_MelbourneAppDelegate.m
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Vintage_Fashion_MelbourneAppDelegate.h"

#import "RootViewController.h"

#import "ExploreMapViewController.h"

@implementation Vintage_Fashion_MelbourneAppDelegate

@synthesize window=_window;

@synthesize splitViewController=_splitViewController;

@synthesize rootViewController=_rootViewController;

@synthesize detailViewController=_detailViewController;

@synthesize exploreMapViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the split view controller's view to the window and display.
    
    //self.mapWindow.rootViewController = self.exploreMapViewController;
    
    self.window.rootViewController = self.splitViewController;
    
    [self.window makeKeyAndVisible];
    
    self.splitViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.splitViewController presentModalViewController:[[self.splitViewController viewControllers] objectAtIndex:1] animated:NO];
    
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
}



- (void)dealloc
{
    [exploreMapViewController release];
    [_window release];
    [_splitViewController release];
    [_rootViewController release];
    [_detailViewController release];
    [super dealloc];
}

@end
