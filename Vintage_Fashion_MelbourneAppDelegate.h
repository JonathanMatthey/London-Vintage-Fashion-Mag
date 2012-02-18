//
//  Vintage_Fashion_MelbourneAppDelegate.h
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@class DetailViewController;

@class ExploreMapViewController;

@interface Vintage_Fashion_MelbourneAppDelegate : NSObject <UIApplicationDelegate> {
    ExploreMapViewController *exploreMapViewController;
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, retain) IBOutlet ExploreMapViewController *exploreMapViewController;


@end
