//
//  MapDetailViewController.h
//  Melbourne Secrets2
//
//  Created by Jonathan Matthey on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *title;
	NSString *subtitle;
	NSString *type;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *subtitle;

@end

@interface GalleryPin : MKAnnotationView
{
}
- (id)initWithAnnotation:(id <MKAnnotation>) annotation;
@end

@interface ShopPin : MKAnnotationView
{
}
- (id)initWithAnnotation:(id <MKAnnotation>) annotation;
@end


@interface MapDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate,MKMapViewDelegate> {
    
    IBOutlet UITextField *addressField;
    IBOutlet UIButton *goButton;
    IBOutlet MKMapView *map;
    
    
    NSDictionary *mapLocations;
    
	AddressAnnotation *addAnnotation;
}


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) id detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, retain) IBOutlet MKMapView *map;



@property (nonatomic, retain) NSDictionary *mapLocations;

- (IBAction) showAddress;

- (CLLocationCoordinate2D) addressLocation;

- (IBAction) closeWindow;

@end
