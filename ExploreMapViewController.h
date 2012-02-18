//
//  ExploreMapViewController.h
//  Vintage Fashion London
//
//  Created by Jonathan Matthey on 26/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

#define kTitleValueTag          1
#define kAddressValueTag        2
#define kDescriptionValueTag    3 
#define kImageValueTag          4

#define rowHeight       450
#define sectionHeight   44
#define tableWidth      323

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *title;
	NSString *subtitle;
	NSString *type;
	NSString *imageName;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *imageName;

@end

@interface ExploreMapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *locationsTableView;
    UITableViewCell *tvCell;
    IBOutlet MKMapView *map;
    
    
    //TableView Related
    NSMutableArray *sectionArray;
    NSMutableArray *cellArray;
    NSMutableArray *cellCount;
    
    AddressAnnotation *addAnnotation;
    
}

@property (nonatomic,retain) IBOutlet UITableViewCell *tvCell;
@property (nonatomic,retain) IBOutlet UITableView *locationsTableView;

@property (nonatomic, retain) IBOutlet MKMapView *map;


- (IBAction) closeWindow;

- (IBAction)setMapType:(id)sender;

- (void) hideMapView:(id)sender;


@end
