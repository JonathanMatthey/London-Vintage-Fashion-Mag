//
//  DetailViewController.m
//  Melbourne Secrets2
//
//  Created by Jonathan Matthey on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapDetailViewController.h"

#import "MapRootViewController.h"

#import "MapKit/MapKit.h"

#import "Vintage_Fashion_MelbourneAppDelegate.h"
#import "LocationAnnotationView.h"

@interface MapDetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation AddressAnnotation

@synthesize coordinate;

@synthesize title,subtitle,type;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

-(void)dealloc{
    [title dealloc];
    [subtitle dealloc];
    [type dealloc];
    [super dealloc];
}

@end

@implementation GalleryPin

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
{
    self = [super initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
    
    if (self)        
    {
        UIImage*    theImage = [UIImage imageNamed:@"gallery-pin.png"];
        
        if (!theImage)
            return nil;
        
        self.image = theImage;
    }    
    return self;
}
@end

@implementation ShopPin

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
{
    self = [super initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
    
    if (self)        
    {
        UIImage*    theImage = [UIImage imageNamed:@"shop-pin.png"];
        
        if (!theImage)
            return nil;
        
        self.image = theImage;
    }    
    return self;
}
@end

@implementation MapDetailViewController

@synthesize map;

@synthesize toolbar=_toolbar;

@synthesize detailItem=_detailItem;

@synthesize detailDescriptionLabel=_detailDescriptionLabel;

@synthesize popoverController=_myPopoverController;

@synthesize mapLocations;

- (IBAction) closeWindow {
    
    Vintage_Fashion_MelbourneAppDelegate *myAppDelegate = (Vintage_Fashion_MelbourneAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //self.window.rootViewController = self.splitViewController;
    [myAppDelegate.mapWindow setHidden:YES];
    [myAppDelegate.window makeKeyAndVisible];
}

- (IBAction) showAddress {
	//Hide the keypad
	[addressField resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	CLLocationCoordinate2D location = [self addressLocation];
/*	region.span=span;
	region.center=location;
	
	if(addAnnotation != nil) {
		[mapView removeAnnotation:addAnnotation];
		[addAnnotation release];
		addAnnotation = nil;
	}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
	[mapView addAnnotation:addAnnotation];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];*/
	//[mapView selectAnnotation:mLodgeAnnotation animated:YES];
}

-(CLLocationCoordinate2D) addressLocation {
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv&key=ABQIAAAABfhLrxPl6XNipynG-ItTThSiL1iYTQXEGNmNSrDiOXr0aSpkRBQlL0wsp44kRpesz8lHHJuR3pTLfQ", 
                           [addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"urlString to google:");
//    NSLog(@"%@",urlString);

	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	double latitude = 0.0;
	double longitude = 0.0;
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
//        NSLog(@"%f",latitude);
//        NSLog(@"%f",longitude);
	}
	else {
		//Show error
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    }
    
    NSLog(@"%@",annotation.title);
    
    annotationView.image = [UIImage imageNamed:@"gallery-pin.png"];
    annotationView.annotation = annotation;
    
    return annotationView;
}


#pragma mark - Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    self.detailDescriptionLabel.text = [self.detailItem description];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D location;
    
    for (NSString *key in [self.mapLocations allKeys])
    {
        NSArray *locationsInSection = [self.mapLocations objectForKey:key];
        
        // loop through the locations plist
        for (NSDictionary *dict in locationsInSection) {
//            NSLog(@"%@", [dict objectForKey:@"name"]);
            location.latitude = [(NSNumber *)[dict objectForKey:@"latitude"] doubleValue];
            location.longitude = [(NSNumber *)[dict objectForKey:@"longitude"] doubleValue];
            
            addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
            
            addAnnotation.title = [dict objectForKey:@"name"];
            addAnnotation.subtitle = [dict objectForKey:@"address"];
            NSLog(@"addannotation");
            [self.map addAnnotation:addAnnotation];
            
            [addAnnotation release];
        }
    }
    
    // set the region, the area the map shows, according to the last location plotted.
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.01;
    region.span=span;
    region.center=location;
    
    [self.map setRegion:region animated:TRUE];
    [self.map regionThatFits:region];
    
//    //Hide the keypad
//	MKCoordinateRegion region;
//	MKCoordinateSpan span;
//	span.latitudeDelta=0.2;
//	span.longitudeDelta=0.2;
//	
//	CLLocationCoordinate2D location = [self addressLocation];
//	region.span=span;
//	region.center=location;
//	
//	if(addAnnotation != nil) {
//		[mapView removeAnnotation:addAnnotation];
//		[addAnnotation release];
//		addAnnotation = nil;
//	}
//	
//	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
//	[mapView addAnnotation:addAnnotation];
//	
//	[mapView setRegion:region animated:TRUE];
//	[mapView regionThatFits:region];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Events";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{

    [super viewDidLoad];
    //NSLog(@"viewdidload - mapdetailviewcontroller");

}


- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
    self.mapLocations = nil;
    self.map = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [map release];
    [mapLocations release];
    [_myPopoverController release];
    [_toolbar release];
    [_detailItem release];
    [_detailDescriptionLabel release];
    [super dealloc];
}

@end
