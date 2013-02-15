//
//  CNOverlayView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/15/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNOverlayView.h"

@implementation CNOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawMapRect:(MKMapRect) inMapRect zoomScale:(MKZoomScale) inZoomScale inContext:(CGContextRef) inContext
{
    UIImage *tmpOverlayImage = [[UIImage imageNamed:@"overlay"] retain];
    
    CGImageRef tmpImageReference = tmpOverlayImage.CGImage;
    
    MKMapRect tmpMapRect = [self.overlay boundingMapRect];
    CGRect tmpRect = [self rectForMapRect:tmpMapRect];
    CGRect tmpClipRect = [self rectForMapRect: inMapRect];
    
    CGContextAddRect(inContext, tmpClipRect);
    CGContextClip(inContext);
    
    CGContextDrawImage(inContext, tmpRect, tmpImageReference);

    [tmpOverlayImage release];
    
}

@end
