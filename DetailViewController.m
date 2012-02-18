//
//  DetailViewController.m
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

#import "RootViewController.h"

#import "Vintage_Fashion_MelbourneAppDelegate.h"

#import "ExploreMapViewController.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)


@interface DetailViewController ()
//@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize toolbar=_toolbar;
@synthesize detailItem=_detailItem;
@synthesize detailDescriptionLabel=_detailDescriptionLabel;
@synthesize popoverController=_myPopOverController;
@synthesize scrollView1, scrollView2, scrollView0, inspirationView, interview1View, interview1bView,interview2View, interview2bView;
@synthesize landscapeView,portraitView;
@synthesize mailFeedbackMsg;

const CGFloat kScrollObjHeight	= 1004.0;
const CGFloat kScrollObjWidth	= 768.0;
const NSUInteger kNumImages		= 4;

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration { 
    
    // if toolbar isnt hidden then we're in the mag view, otherwise we're in the map
//    if (_toolbar.hidden == NO)
//    {
        if (interfaceOrientation == UIInterfaceOrientationPortrait) {
            self.view = portraitView;
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
            self.view.bounds = CGRectMake(0.0, 0.0, 768.0, 1000.0);
        } else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            self.view = landscapeView;
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
            self.view.bounds = CGRectMake(0.0, 0.0, 1040.0, 728.0);
        } else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
            self.view = portraitView;
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform =
            CGAffineTransformMakeRotation(degreesToRadians(180));
            self.view.bounds = CGRectMake(0.0, 0.0, 768.0, 1000.0);
        } else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) { 
            self.view = landscapeView;
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform =
            CGAffineTransformMakeRotation(degreesToRadians(90));
            self.view.bounds = CGRectMake(0.0, 0.0, 1040.0, 728.0);
        }
//    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchbegan");

}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchended");
    
}
- (IBAction) toggleToolbar:(id)sender{
    
    //NSLog(@"toolbar slide... ?");
    if (_toolbar.frame.origin.y == 0)
    {
        //NSLog(@"toolbar slide up");
        // Fade out the view right away
        
        CGRect frame =  _toolbar.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        
        // Slide up based on y axis
        frame.origin.y = -44;
        [_toolbar setFrame:frame];
        
        [UIView commitAnimations];
        
        
    }
    else
    {
        //NSLog(@"toolbar slide down");
        // Fade out the view right away
        
        CGRect frame =  _toolbar.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        
        // Slide up based on y axis
        frame.origin.y = 0;
        [_toolbar setFrame:frame];
        
        [UIView commitAnimations];
    }
    
}

- (IBAction) switchToMapView{
    
    Vintage_Fashion_MelbourneAppDelegate *myAppDelegate = (Vintage_Fashion_MelbourneAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    [myAppDelegate.splitViewController viewWillDisappear:YES];
    [myAppDelegate.exploreMapViewController viewWillAppear:YES];
    
    //[myAppDelegate.window insertSubview: myAppDelegate.exploreMapViewController.view atIndex:0];
    [self.view insertSubview:myAppDelegate.exploreMapViewController.view atIndex:1];
    [_toolbar setHidden:YES];
    
    [myAppDelegate.splitViewController  viewDidDisappear:YES];
    [myAppDelegate.exploreMapViewController viewDidAppear:YES];

    [UIView commitAnimations];
    
//    [myAppDelegate.window makeKeyAndVisible];
//    [blueViewController.view removeFromSuperview];
//    [self.view insertSubview:yellowViewController.view atIndex:0];
    
}



- (void) hideRootViewController:(id)sender
{
    Vintage_Fashion_MelbourneAppDelegate *myAppDelegate = (Vintage_Fashion_MelbourneAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [myAppDelegate.window.rootViewController.view removeFromSuperview];
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


#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Pages";
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

- (void)layoutScrollImages2
{
    UIImageView *view = nil;
	NSArray *subviews;
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curYLoc = 0;
	
    
    view = nil;
	subviews = [scrollView2 subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	curYLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
            
			CGRect frame = view.frame;
            frame.origin = CGPointMake(0,curYLoc);
			view.frame = frame;
			
			curYLoc += (kScrollObjHeight);
		}
	}
	
	// set the content size so it can be scrollable
	[scrollView2 setContentSize:CGSizeMake((kScrollObjWidth), (kScrollObjHeight * 4))];
    
    
}
- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [scrollView1 subviews];
    UIImageView *view2 = nil;
    NSArray *subviews2 = nil;
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
    CGFloat curYLoc;
	for (view in subviews)
	{
        
		if (([view isKindOfClass:[UIImageView class]]) && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
            
            //NSLog(@"UIIMAGEVIEW tag: %d at x: %f y:%d",[view tag], curXLoc,0);
			
			curXLoc += (kScrollObjWidth);
            
            
		}
        if (([view isKindOfClass:[UIScrollView class]]) && view.tag > 0)
		{
            UIScrollView *uiScrollView = (UIScrollView *) view;
            
            curYLoc = 0;
            
            view2 = nil;
            subviews2 = [uiScrollView subviews];
            
            for (view2 in subviews2){
                
                if (([view2 isKindOfClass:[UIImageView class]]) && view2.tag > 0)
                {
                    
                    CGRect frame2 = view2.frame;
                    frame2.origin = CGPointMake(0, curYLoc);
                    view2.frame = frame2;
                    
                    //NSLog(@"UIIMAGEVIEW tag: %d at x: %d y:%f",[view2 tag],0,curYLoc);

                    curYLoc += kScrollObjHeight;
                }
                
            }
            
			CGRect frame = uiScrollView.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			uiScrollView.frame = frame;
            
            //NSLog(@"UIScroll View tag: %d at x: %f y:%d",[uiScrollView tag],curXLoc,0);
			
            
            
			curXLoc += (kScrollObjWidth);
            
            [uiScrollView setContentSize:CGSizeMake(( kScrollObjWidth), (3 * kScrollObjHeight))];
            uiScrollView.clipsToBounds = YES;
            
            CGPoint scrollOffset = CGPointMake(0,kScrollObjHeight);
            [uiScrollView setContentOffset:scrollOffset];
            [uiScrollView setScrollEnabled:YES];

		}
	}
	
	// set the content size so it can be scrollable
	//[scrollView1 setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollView1 bounds].size.height)];
    [scrollView1 setContentSize:CGSizeMake((5 * kScrollObjWidth), kScrollObjHeight-500)];
    scrollView1.clipsToBounds = YES;
}

- (void) loadImagesInScrollView{
    
}

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"viewdidload - detailviewcontroller");

    // 1. setup the scrollview for multiple images and add it to the view controller
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[scrollView0 setBackgroundColor:[UIColor blackColor]];
	[scrollView0 setCanCancelContentTouches:NO];
	scrollView0.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	scrollView0.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView0.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	scrollView0.pagingEnabled = YES;
    
	// set the content size so it can be scrollable
	[scrollView0 setContentSize:CGSizeMake((8 * kScrollObjWidth), kScrollObjHeight)];

    // image for inspiration
    NSString *imageName = [NSString stringWithFormat:@"inspiration.jpg"];
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *buttonBackground = [[UIButton alloc] init];

    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    CGRect rect = buttonBackground.frame;
    rect.size.height = kScrollObjHeight;
    rect.size.width = kScrollObjWidth;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside]; 
    
    buttonBackground.frame = rect;
    [inspirationView addSubview:buttonBackground];
    [buttonBackground release];
    
    
    // image for interview1
    imageName = [NSString stringWithFormat:@"interview1.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = kScrollObjHeight;
    rect.size.width = kScrollObjWidth / 2;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside]; 
    
    buttonBackground.frame = rect;
    [interview1View addSubview:buttonBackground];
    [buttonBackground release];
    
    // 1. setup scroll view for interview text 
	[interview1bView setBackgroundColor:[UIColor whiteColor]];
	[interview1bView setCanCancelContentTouches:NO];
	interview1bView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	interview1bView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	interview1bView.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
    
	// set the content size so it can be scrollable
	[interview1bView setContentSize:CGSizeMake(( kScrollObjWidth/2), 2500)];

    
    // image for interview1b - the scrolling text
    imageName = [NSString stringWithFormat:@"interview1b.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = 2500;
    rect.size.width = kScrollObjWidth / 2;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside]; 
    
    buttonBackground.frame = rect;
    [interview1bView addSubview:buttonBackground];
    [buttonBackground release];
    // -------------------------------------
    
    // image for interview2
    imageName = [NSString stringWithFormat:@"interview2.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = kScrollObjHeight;
    rect.size.width = kScrollObjWidth / 2;
    
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside]; 
    
    buttonBackground.frame = rect;
    [interview2View addSubview:buttonBackground];
    [buttonBackground release];
    
    // 1. setup scroll view for interview text 
	[interview2bView setBackgroundColor:[UIColor whiteColor]];
	[interview2bView setCanCancelContentTouches:NO];
	interview2bView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	interview2bView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	interview2bView.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
    
	// set the content size so it can be scrollable
	[interview2bView setContentSize:CGSizeMake(( kScrollObjWidth/2), 4100)];
    
    
    // image for interview1b - the scrolling text
    imageName = [NSString stringWithFormat:@"interview2b.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = 4100;
    rect.size.width = kScrollObjWidth / 2;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside];   
    
    buttonBackground.frame = rect;
    [interview2bView addSubview:buttonBackground];
    [buttonBackground release];
    // -------------------------------------
    // top vintage shops
    
    
    // image for interview2
    imageName = [NSString stringWithFormat:@"topvintageshops.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = 4016;
    rect.size.width = kScrollObjWidth;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside];   
    
    buttonBackground.frame = rect;
    [scrollView1 addSubview:buttonBackground];
    [buttonBackground release];
    // -------------------------------------
    
    
    // -------------------------------------
    // top vintage shops
    
    
    // image for interview2
    imageName = [NSString stringWithFormat:@"dosandonts1.jpg"];
    image = [UIImage imageNamed:imageName];
    buttonBackground = [[UIButton alloc] init];
    
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    rect = buttonBackground.frame;
    rect.size.height = 4016;
    rect.size.width = kScrollObjWidth;
    
    // set the background image
    [buttonBackground setBackgroundImage:image forState:UIControlStateNormal];
    [buttonBackground setBackgroundImage:image forState:UIControlStateHighlighted];
    [buttonBackground addTarget:self action:@selector(toggleToolbar:) forControlEvents:UIControlEventTouchUpInside];   
    
    buttonBackground.frame = rect;
    [scrollView2 addSubview:buttonBackground];
    [buttonBackground release];
    // -------------------------------------
    
	// set the content size so it can be scrollable
	[scrollView1 setContentSize:CGSizeMake((kScrollObjWidth), (4016))];
    
    
    // video for emmasoup
    NSString *url = [[NSBundle mainBundle] 
                     pathForResource:@"emmasoup5" 
                     ofType:@"mp4"];
    MPMoviePlayerController *player = 
    [[MPMoviePlayerController alloc] 
     initWithContentURL:[NSURL fileURLWithPath:url]];
    
    [player setShouldAutoplay:NO];
    
//    [[NSNotificationCenter defaultCenter] 
//     addObserver:self
//     selector:@selector(movieFinishedCallback:)
//     name:MPMoviePlayerPlaybackDidFinishNotification
//     object:player];
    
    //---play partial screen---
    player.view.frame = CGRectMake(30, 385, 700, 394);
    [inspirationView addSubview:player.view];
    
    [player release];
    
    //---play movie---
    //[player play];
	
    
	[self layoutScrollImages2];	// now place the photos in serial layout within the scrollview
	
    
	// 1. setup the scrollview for multiple images and add it to the view controller
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[scrollView1 setBackgroundColor:[UIColor blackColor]];
	[scrollView1 setCanCancelContentTouches:NO];
	scrollView1.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView1.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView1.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	scrollView1.pagingEnabled = YES;
    
    
	// 1. setup the scrollview for multiple images and add it to the view controller
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[scrollView2 setBackgroundColor:[UIColor blackColor]];
	[scrollView2 setCanCancelContentTouches:NO];
	scrollView2.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView2.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView2.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	scrollView2.pagingEnabled = YES;
    
}


- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView0 = nil;
    self.scrollView1 = nil;
    self.scrollView2 = nil;
    self.inspirationView = nil;
    self.interview1bView = nil;
    self.interview1View = nil;;
    self.interview2bView = nil;
    self.interview2View = nil;
    self.mailFeedbackMsg = nil;
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
    [scrollView0 release];
    [scrollView1 release];
    [scrollView2 release];
    [inspirationView release];
    [interview1View release];
    [interview1bView release];
    [interview2View release];
    [interview2bView release];
    [mailFeedbackMsg release];
    [_toolbar release];
    [_detailItem release];
    [popoverController release];
    [_detailDescriptionLabel release];
    [portraitView release];
    [landscapeView release];
    [super dealloc];
}



#pragma mark -
#pragma mark Show Mail/SMS picker

-(IBAction)showMailPicker:(id)sender {
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device 
	// can send emails.	Display feedback message, otherwise.
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
	if (mailClass != nil) {
        //[self displayMailComposerSheet];
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet];
		}
		else {
			mailFeedbackMsg.hidden = NO;
			mailFeedbackMsg.text = @"Device not configured to send mail.";
		}
	}
	else	{
		mailFeedbackMsg.hidden = NO;
		mailFeedbackMsg.text = @"Device not configured to send mail.";
	}
}



#pragma mark -
#pragma mark Compose Mail/SMS

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayMailComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Feedback on Vintage Fashion Mag"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"feedback@vintagefashionmag.com"]; 
	
	[picker setToRecipients:toRecipients];
	
	// Fill out the email body text
	NSString *emailBody = @"Hi, just writing to say: ...";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}




#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the 
// message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	mailFeedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			mailFeedbackMsg.text = @"Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			mailFeedbackMsg.text = @"Mail saved";
			break;
		case MFMailComposeResultSent:
			mailFeedbackMsg.text = @"Your feedback was sent, thanks";
			break;
		case MFMailComposeResultFailed:
			mailFeedbackMsg.text = @"Mail sending failed";
			break;
		default:
			mailFeedbackMsg.text = @"Mail not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}



@end
