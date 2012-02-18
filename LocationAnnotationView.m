//
//  LocationAnnotationView.m
//  Vintage Fashion Melbourne
//
//  Created by Jonathan Matthey on 25/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationAnnotationView.h"

@implementation LocationAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"Image attached to pin ?");

    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
//        
//        CGRect frame = self.frame;
//        frame.size = CGSizeMake(60.0, 85.0);
//        self.frame = frame;
//        self.backgroundColor = [UIColor clearColor];
//        self.centerOffset = CGPointMake(30.0, 42.0);
        
        UIImage* theImage = [UIImage imageNamed:@"partly_cloudy.png"];
        NSLog(@"Image attached to pin ?");
        if (!theImage)
            return nil;

        self.image = theImage;
    }
    return self;
}

@end
