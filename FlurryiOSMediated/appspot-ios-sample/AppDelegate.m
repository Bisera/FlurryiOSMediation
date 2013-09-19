//
//  AppDelegate.m
//  appspot-ios-sample
//
//  Created by Anthony Watkins on 8/3/12.
//  Copyright (c) 2012 Flurry. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "Flurry.h"
#import "FlurryAds.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    self.window.rootViewController = self.viewController;
    
    // Init Flurry
    
    [Flurry startSession:@"BFB9YSXJ72ZD66F99WRM"];
    [Flurry setDebugLogEnabled:YES];
    [Flurry setLogLevel:FlurryLogLevelAll];
    [FlurryAds enableTestAds:NO];
    
    [FlurryAds initialize:self.viewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}


@end
