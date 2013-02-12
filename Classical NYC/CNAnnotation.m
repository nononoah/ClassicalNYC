//
//  CNPinView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNAnnotation.h"

@implementation CNAnnotation

- (id) initWithCoordinate: (CLLocationCoordinate2D) inCoordinate andTitle: (NSString *) inTitle andSubtitle: (NSString *) inSubtitle
{
    self = [super init];
    if (self) {
        _coordinate = inCoordinate;
        _title = inTitle;
        _subtitle = inSubtitle;
    
    }
    return self;
}

- (id) initWithCoordinate:( CLLocationCoordinate2D)inCoordinate andBoundingMapRect: (MKMapRect) inBoundingMapRect
{
    self = [super init];
    if (self) {
        _coordinate = inCoordinate;
        _bounding = inBoundingMapRect;
    }
    return self;
}


- (void) dealloc
{
    [_title release];
    [super dealloc];
}
@end
