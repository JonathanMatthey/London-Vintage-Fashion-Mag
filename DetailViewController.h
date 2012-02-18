//
//  DetailViewController.h
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, MFMailComposeViewControllerDelegate> {
    
    IBOutlet UIView *landscapeView;
    IBOutlet UIView *portraitView;
    
    IBOutlet UIView *inspirationView;
    IBOutlet UIScrollView *scrollView0;
    IBOutlet UIScrollView *scrollView1;
    IBOutlet UIScrollView *scrollView2;
    //IBOutlet UIToolbar *toolbar;
    IBOutlet UIView *interview1View;
    IBOutlet UIScrollView *interview1bView;
    IBOutlet UIView *interview2View;
    IBOutlet UIScrollView *interview2bView;
    UIPopoverController *popoverController;

	IBOutlet UILabel *mailFeedbackMsg;
}


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) id detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView0;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView1;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView2;
@property (nonatomic, retain) IBOutlet UIView *inspirationView;
@property (nonatomic, retain) IBOutlet UIView *interview1View;
@property (nonatomic, retain) IBOutlet UIScrollView *interview1bView;
@property (nonatomic, retain) IBOutlet UIView *interview2View;
@property (nonatomic, retain) IBOutlet UIScrollView *interview2bView;
@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;

@property (nonatomic, retain) IBOutlet UIView *landscapeView;
@property (nonatomic, retain) IBOutlet UIView *portraitView;

- (IBAction) switchToMapView;

- (IBAction) toggleToolbar:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *mailFeedbackMsg;

-(IBAction)showMailPicker:(id)sender;
-(void)displayMailComposerSheet;

- (void) hideRootViewController:(id)sender;


@end
