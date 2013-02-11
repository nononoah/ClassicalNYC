//
//  CNMapView.m
//  Classical NYC
//
//  Created by Noah Blake on 2/11/13.
//  Copyright (c) 2013 Noah Blake. All rights reserved.
//

#import "CNMapView.h"
#import "CNVenueList.h"
#import "CNVenue.h"
#import "CNPinAnnotation.h"

@implementation CNMapView

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Map";
    }
    return self;
}

- (void) viewDidLoad
{
    MKMapView *tmpMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];

    // {} shortcut for defining structs
    CLLocationCoordinate2D tmpCenter = {40.7142, -74.006}; //latitude, longitude
    MKCoordinateSpan tmpSpan = {.2, .2}; //degrees of lat and long span includes
    MKCoordinateRegion tmpRegion = {tmpCenter, tmpSpan}; //region sets default location and zoom for map when it opens
    tmpMapView.region = tmpRegion;
    
    int i = 0;
    for (CNVenue *tmpVenue in VENUELIST)
    {
        DLog(@"Counting steps: %i", i);
        DLog(@"Class of object at index i: %@", [[VENUELIST objectAtIndex: i] class]);
        DLog(@"tmpVenue's name: %f", tmpVenue.longitude.doubleValue);
        i++;
    }
    
    [self.view addSubview: tmpMapView];
}



@end
