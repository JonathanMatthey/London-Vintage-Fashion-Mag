//
//  RootViewController.h
//  Melbourne Secrets2
//
//  Created by Jonathan Matthey on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTitleValueTag          1
#define kAddressValueTag        2
#define kDescriptionValueTag    3 
#define kImageValueTag          4

#define rowHeight 360
#define sectionHeight 44
#define tableWidth 323

@class MapDetailViewController;

@interface MapRootViewController : UITableViewController {
    MapDetailViewController *mapDetailViewController;
    NSDictionary *mapLocations;
    NSArray *mapLocationKeys;
    
    UITableViewCell *tvCell;
    
    //TableView Related
    NSMutableArray *sectionArray;
    NSMutableArray *cellArray;
    NSMutableArray *cellCount;

}

@property (nonatomic, retain) IBOutlet MapDetailViewController *mapDetailViewController;
@property (nonatomic, retain) NSDictionary *mapLocations;
@property (nonatomic, retain) NSArray *mapLocationKeys;

@property (nonatomic,retain) IBOutlet UITableViewCell *tvCell;

@end
