//
//  RootViewController.h
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define kPageNameValueTag 2
#define kPageTypeValueTag 1
#define kPageImageValueTag 3

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    UITableViewCell *pageCell;
    
    NSMutableArray *pages;
    

}

		
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic,retain) IBOutlet UITableViewCell *pageCell;
@property (nonatomic,retain) NSMutableArray *pages;

@end
