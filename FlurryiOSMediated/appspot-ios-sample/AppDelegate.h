//
//  AppDelegate.h
//  appspot-ios-sample
//
//  Created by Anthony Watkins on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlurryAdDelegate.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FlurryAdDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
