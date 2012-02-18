//
//  ExploreMapViewController.m
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 26/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExploreMapViewController.h"
#import "Vintage_Fashion_MelbourneAppDelegate.h"
#import "DetailViewController.h"

@implementation AddressAnnotation

@synthesize coordinate;

@synthesize title,subtitle,type,imageName;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

-(void)dealloc{
    [title dealloc];
    [subtitle dealloc];
    [type dealloc];
    [imageName release];
    [super dealloc];
}

@end

@implementation ExploreMapViewController

@synthesize tvCell, locationsTableView, map;

- (void)viewDidLoad
{
    
    // NSLog(@"viewdidload - maprootviewcontroller");
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MapLocations" ofType:@"plist"];
    NSDictionary *allLocations = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //mapDetailViewController.mapLocations = allLocations;
    
    //Init the Arrays of the tableview
    sectionArray=[[NSMutableArray alloc]initWithArray:[allLocations allKeys]];
    cellArray=[[NSMutableArray alloc]init];
    cellCount=[[NSMutableArray alloc]init];
    
    for(NSString *key in sectionArray)
    {
        //NSLog(@"Adding array for section:%@",key);
        NSMutableArray *_cellArray=[[NSMutableArray alloc]initWithArray:[allLocations objectForKey:key]];
        [cellArray addObject:_cellArray];
        [cellCount addObject:[NSNumber numberWithInt:[_cellArray count]]];
        [_cellArray release];
        //NSLog(@"Section array count:%d",[_cellArray count]);
    }
    
    [self.locationsTableView reloadData];
    
    [super viewDidLoad];
}


- (void)dealloc{
    [locationsTableView release];
    [map release];
    [tvCell release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    NSArray *pinImageNames = [[NSArray alloc] initWithObjects:@"pin-shop.png",@"pin-charity.png", nil];
    
    CLLocationCoordinate2D location;
    int locationDictArrayIndex = 0;
    
    // default location in case no data in dictionary
    location.latitude = 51.514958;
    location.longitude = -0.1444629;
    
    for (NSMutableArray *locationDictArray in cellArray){
       
        for (NSDictionary *locationDict in locationDictArray)
        {        
            //            NSLog(@"%@", [dict objectForKey:@"name"]);
            location.latitude = [(NSNumber *)[locationDict objectForKey:@"latitude"] doubleValue];
            location.longitude = [(NSNumber *)[locationDict objectForKey:@"longitude"] doubleValue];
            
            addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
            
            addAnnotation.title = [locationDict objectForKey:@"name"];
            addAnnotation.subtitle = [locationDict objectForKey:@"address"];
            addAnnotation.imageName = [pinImageNames objectAtIndex:locationDictArrayIndex];
            [self.map addAnnotation:addAnnotation];
            
            [addAnnotation release];
        }
        locationDictArrayIndex++;
        
    }
    [pinImageNames release];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (IBAction) closeWindow {
    
    Vintage_Fashion_MelbourneAppDelegate *myAppDelegate = (Vintage_Fashion_MelbourneAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:myAppDelegate.window cache:YES];
    
    [myAppDelegate.exploreMapViewController viewWillDisappear:YES];
    [myAppDelegate.splitViewController viewWillAppear:YES];
    
    [myAppDelegate.exploreMapViewController.view removeFromSuperview];
    
    [myAppDelegate.detailViewController.toolbar setHidden:NO];
    
    [myAppDelegate.exploreMapViewController  viewDidDisappear:YES];
    [myAppDelegate.splitViewController viewDidAppear:YES];
    
    [UIView commitAnimations];

}

- (void) hideMapView:(id)sender
{
    Vintage_Fashion_MelbourneAppDelegate *myAppDelegate = (Vintage_Fashion_MelbourneAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [myAppDelegate.exploreMapViewController.view removeFromSuperview];
}

- (IBAction)setMapType:(id)sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
    {
        case 0:
        {
            map.mapType = MKMapTypeStandard;
            break;
        } 
        case 1:
        {
            map.mapType = MKMapTypeSatellite;
            break;
        } 
        default:
        {
            map.mapType = MKMapTypeHybrid;
            break;
        } 
    }
}

# pragma mark -
# pragma mark Tableview Delegate Methods

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    
    if (annotation == map.userLocation)
    {
        return nil;
    }
    else 
    {
        
        static NSString *AnnotationViewID = @"annotationViewID";
        
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        }
        
        AddressAnnotation *aa = (AddressAnnotation*)annotation;
        
        annotationView.image = [UIImage imageNamed:aa.imageName];
        annotationView.annotation = aa;
        
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == map.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=0.05;
            span.longitudeDelta=0.05;
            
            CLLocationCoordinate2D location;
            
            location = map.userLocation.location.coordinate;
            
            region.span=span;
            region.center=location;
            
            [map setRegion:region animated:TRUE];
            [map regionThatFits:region];
        }
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    //NSLog(@"number of sections in tableview: %d", [self.mapLocationKeys count]);
    
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    //    if (sectionsShowHideFlags[section]) {
    //        ///we want the number of people plus the header cell
    //        
    //        NSString *key = [self.mapLocationKeys objectAtIndex:section];
    //        NSArray *locationSection = [self.mapLocations objectForKey:key];
    //        return [locationSection count];
    //    
    //    } else {
    //        ///we just want the header cell
    //        return 1;
    //    }
    //
    //    if ([self.mapLocationKeys count] == 0){
    //        return 0;
    //    }
    
    return [[cellCount objectAtIndex:section] intValue];

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeight;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //View with the button to expand and shrink and 
    //Label to display the Heading.
    UIView *headerView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)] autorelease];
    
    
    NSString *imageName = [[NSString alloc] initWithFormat: @"sectionBg%d.png",section];
    //Background Image
    UIImageView *headerBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [headerView addSubview:headerBg];
    
    [imageName release];
    [headerBg release];
    
//    //Button
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(0, 0, tableView.bounds.size.width, 44);
//    button.tag=section+1;
//    [button addTarget:self action:@selector(headerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    //[button setImage:[UIImage imageNamed:@"shrink.png"] forState:UIControlStateNormal];
//    //[button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
//    
//    if([[cellCount objectAtIndex:section] intValue]==0) button.selected=YES;
//    else button.selected=NO;
//    
//    [headerView addSubview:button];
    
    //Label
    UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(30, 7, 300, 30)];
    [headerTitle setBackgroundColor:[UIColor clearColor]];
    [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    [headerTitle setTextColor:[UIColor whiteColor]];
    [headerTitle setText:[sectionArray objectAtIndex:section]];
    [headerView addSubview:headerTitle];
    
    [headerTitle release];
    
    return  headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
    /*
     <#mapDetailViewController#> *mapDetailViewController = [[<#mapDetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:mapDetailViewController animated:YES];
     [mapDetailViewController release];
     */
    
    //    NSDictionary *president = [self.presidents objectAtIndex:indexPath.row];
    //    NSString *urlString = [president objectForKey:@"url"];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"pres" message:urlString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    //    
    //    [alert show];
    //    [alert release];
    
    //    if (indexPath.row == 0) {
    //        ///it's the first row of any section so it would be your custom section header
    //        
    //        ///put in your code to toggle your boolean value here
    //            sectionsShowHideFlags[indexPath.section] = !  sectionsShowHideFlags[indexPath.section];
    //         
    //        ///reload this section
    //        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    //    }
    //    else {
    
    
    CLLocationCoordinate2D location;

    NSDictionary *locationDict = [[cellArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    location.latitude = [(NSNumber *)[locationDict objectForKey:@"latitude"] doubleValue];
    location.longitude = [(NSNumber *)[locationDict objectForKey:@"longitude"] doubleValue];
        
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.01;
    region.span=span;
    region.center=location;
    
    [self.map setRegion:region animated:TRUE];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView scrollToRowAtIndexPath: indexPath
                          atScrollPosition:UITableViewScrollPositionTop 
                                  animated:YES];
//    [UIView animateWithDuration: 2.0
//                     animations: ^{
//                         [tableViewExercises scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:previousSelectedExerciseCell inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//                     }completion: ^(BOOL finished){
//                     }
//     ];


    //    }
    
}

# pragma mark -
# pragma mark Table Data Source  Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MapCustomCell" owner:self options:nil];
        if ([nib count] > 0){
            cell = self.tvCell;
        } else {
            NSLog(@"Failed to load CustomCell nib file!");            
        }
    }
    
    NSDictionary *location = [[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    // title first
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:kTitleValueTag];
    titleLabel.text = [location objectForKey:@"name"];
    
    // then the address
    UILabel *addressLabel = (UILabel *)[cell viewWithTag:kAddressValueTag];
    addressLabel.text = [location objectForKey:@"address"];
    
    // description text which has variable height
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:kDescriptionValueTag];
    NSString *descString = [location objectForKey:@"description"];
    
    CGSize maximumSize = CGSizeMake(280, 9999);
    UIFont *descFont = [UIFont fontWithName:@"Times New Roman" size:14];
    CGSize descStringSize = [descString sizeWithFont:descFont 
                                   constrainedToSize:maximumSize 
                                       lineBreakMode:descriptionLabel.lineBreakMode];
    
    // the + 20 is spacing after the text before the image.
    CGRect descFrame = CGRectMake(descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y, 280, descStringSize.height+20);
    
    descriptionLabel.frame = descFrame;
    descriptionLabel.text = descString;
    
    // set the image
    UIImage *img = [UIImage imageNamed:[location objectForKey:@"image"]];
    
    UIImageView *imageLabel = (UIImageView *)[cell viewWithTag:kImageValueTag];
    imageLabel.image = img;
    
    // if the text overflows 111pixels, then that has to come off the image.
    float imageHeightAdjusted = imageLabel.frame.size.height;
    if ((descriptionLabel.frame.size.height + imageLabel.frame.size.height) > 370)
    {
        imageHeightAdjusted = 380 - descriptionLabel.frame.size.height;
    }
    [imageLabel setFrame:CGRectMake(descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height, imageLabel.frame.size.width, imageHeightAdjusted)];
    
    //NSLog(@"before rowtimes??");
    return cell;
    
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


@end
