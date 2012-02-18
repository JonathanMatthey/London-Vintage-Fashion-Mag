//
//  RootViewController.m
//  Melbourne Secrets2
//
//  Created by Jonathan Matthey on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapRootViewController.h"

#import "MapDetailViewController.h"


@implementation MapRootViewController
		
@synthesize mapDetailViewController;
@synthesize mapLocations,mapLocationKeys;
@synthesize tvCell;

bool sectionsShowHideFlags[2] = {YES,YES};

- (void)viewDidLoad
{
    //NSLog(@"viewdidload - maprootviewcontroller");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MapLocations" ofType:@"plist"];
    NSDictionary *allLocations = [NSDictionary dictionaryWithContentsOfFile:path];
    
    mapDetailViewController.mapLocations = allLocations;
    
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
        //NSLog(@"Section array count:%d",[_cellArray count]);
    }
    
    [self.tableView reloadData];
    
    
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

// this was to set VARIABLE HEIGHT TO CELLS but it's overkill i think.

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat floatVal = ([indexPath row]+1.0) * 200;
////
////    UILabel *descriptionLabel = (UILabel *)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:kDescriptionValueTag];
////    CGFloat descHeight = descriptionLabel.frame.size.height;
//  
//    //NSLog(@"desc label at row %d : %@",[indexPath row], tableView );
//    
//    
//    
//    return ([indexPath row]+1.0) * 200; // descHeight + 295;
//}

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
    
    //Button
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, tableView.bounds.size.width, 44);
    button.tag=section+1;
    [button addTarget:self action:@selector(headerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //[button setImage:[UIImage imageNamed:@"shrink.png"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
    
    if([[cellCount objectAtIndex:section] intValue]==0) button.selected=YES;
    else button.selected=NO;
    
    [headerView addSubview:button];
    
    //Label
    UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(30, 7, 300, 30)];
    [headerTitle setBackgroundColor:[UIColor clearColor]];
    [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    [headerTitle setTextColor:[UIColor whiteColor]];
    [headerTitle setText:[sectionArray objectAtIndex:section]];
    [headerView addSubview:headerTitle];
    
    
    return  headerView;
    
    
}


-(IBAction)headerButtonClicked:(id)sender
{
    UIButton *button=(UIButton *)sender;
    NSInteger _index=[sender tag]-1;
    
    if(![button isSelected])
        [cellCount replaceObjectAtIndex:_index withObject:[NSNumber numberWithInt:0]];
    else
        [cellCount replaceObjectAtIndex:_index withObject:[NSNumber numberWithInt:[[cellArray objectAtIndex:_index]count]]];
    
    [self.tableView reloadData];
    
}

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
            //NSLog(@"Failed to load CustomCell nib file!");            
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
    
    CGRect descFrame = CGRectMake(descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y, 280, descStringSize.height);
    
    descriptionLabel.frame = descFrame;
    descriptionLabel.text = descString;
    
    // set the image
    UIImage *img = [UIImage imageNamed:[location objectForKey:@"image"]];
    
    UIImageView *imageLabel = (UIImageView *)[cell viewWithTag:kImageValueTag];
    imageLabel.image = img;
    
    [imageLabel setFrame:CGRectMake(descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height, imageLabel.frame.size.width, imageLabel.frame.size.height)];
    
    //NSLog(@"before rowtimes??");
    return cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


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
    //NSLog(@"row %d selected", indexPath.row);
    //NSLog(@"of section %d selected", indexPath.section);
    
    AddressAnnotation *ann = [[mapDetailViewController.map annotations] objectAtIndex:indexPath.row];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.01;
    span.longitudeDelta=0.01;
    region.span=span;
    region.center=ann.coordinate;

    [mapDetailViewController.map setRegion:region animated:TRUE];
//    }

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.mapLocations = nil;
    self.mapLocationKeys = nil;
    self.tvCell = nil;
}

- (void)dealloc
{
    [sectionArray release];
    [cellArray release];
    [cellCount release];
    [mapLocations release];
    [mapLocationKeys release];
    [tvCell release];
    [mapDetailViewController release];
    [super dealloc];
}

@end
