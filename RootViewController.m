//
//  RootViewController.m
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"

@implementation RootViewController
		
@synthesize detailViewController, pageCell, pages;

- (void)viewDidLoad
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 450.0);
    
    // NSLog(@"viewdidload - maprootviewcontroller");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pages" ofType:@"plist"];
    NSDictionary *allPages = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray *arrayFromFile = [[NSMutableArray alloc] initWithArray:[allPages objectForKey:@"Root"]];
    
    self.pages = arrayFromFile;
    
    [arrayFromFile release];
    
    [super viewDidLoad];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    		
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    // if the toolbar is showing, its on the magazine view, if its hidden hidden - then its the mapview.
    
    if (self.detailViewController.toolbar.hidden == NO)
    {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait ||  toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
    }
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pages count];
    		
}

		
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"PagesCustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PagesCustomCell" owner:self options:nil];
        if ([nib count] > 0){
            cell = self.pageCell;
        } else {
            NSLog(@"Failed to load PagesCustomCell nib file!");            
        }
    }
    
    NSDictionary *page = [pages objectAtIndex:indexPath.row];
    
    // title first
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:kPageNameValueTag];
    nameLabel.text = [page objectForKey:@"name"];
    
    // then the address
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:kPageTypeValueTag];
    typeLabel.text = [page objectForKey:@"type"];
        
    // set the image
    UIImage *img = [UIImage imageNamed:[page objectForKey:@"image"]];
    
    UIImageView *imageLabel = (UIImageView *)[cell viewWithTag:kPageImageValueTag];
    imageLabel.image = img;
    
    [imageLabel setFrame:CGRectMake(5, 5, 35, 45)];
    
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
    [detailViewController.scrollView0 setContentOffset:CGPointMake(768*indexPath.row, 0) animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.detailViewController.popoverController.popoverVisible) {
        [self.detailViewController.popoverController dismissPopoverAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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
}

- (void)dealloc
{
    [detailViewController release];
    [pageCell release];
    [pages release];
    [super dealloc];
}

@end
